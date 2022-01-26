import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:myflutter_cubit/config/config.dart';
import 'package:myflutter_cubit/cubits/auth/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myflutter_cubit/screen/home.dart';
import 'package:myflutter_cubit/screen/register.dart';
import 'package:myflutter_cubit/utils/page_primary.dart';
import 'package:myflutter_cubit/utils/snackbar.dart';
import 'package:myflutter_cubit/widgets/buttons/button_primary.dart';
import 'package:myflutter_cubit/widgets/inputs/input_email.dart';
import 'package:myflutter_cubit/widgets/inputs/input_password.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final TextEditingController _econtroller = TextEditingController();
  final TextEditingController _pcontroller = TextEditingController();
  bool hidePassword = true;

  void _login(BuildContext context) {
    FocusScope.of(context).unfocus();

    final auth = context.read<AuthCubit>();
    final email = _econtroller.text;
    final password = _pcontroller.text;
    final empty = email.isEmpty || password.isEmpty;

    if (empty) {
      context.errorSnackbar('Wrong email or password');
      return;
    }

    auth.login(email, password);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, authState){
        if(authState is Authenticated){
          context.snackbar('Success', 'hai ${authState.userModel.name}');
          Get.to(()=>const HomePage());
        }
        if(authState is AuthFailed){
          context.errorSnackbar( authState.message);
        }
      },
      child: BlocBuilder<AuthCubit, AuthState>(builder: (_, authState) {
        return LoadingOverlay(
            isLoading: authState is AuthLoading ? true : false,
            child: PagePrimary(
              child: Column(
                children: [
                  const Spacer(),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Center(
                      child: CircleAvatar(
                        radius: 50.w,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                      padding: EdgeInsets.all(Insets.lg),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.vertical(top: Corners.xxlRadius)),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Selamat datang kembali !!!",
                                      style: MyTextTheme.body1,
                                    ),
                                    Text(
                                      "Masuk",
                                      style: MyTextTheme.heading4,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            verticalSpace(Insets.lg),
                            InputEmail(controller: _econtroller),
                            verticalSpace(Insets.med),
                            InputPassword(controller: _pcontroller),
                            verticalSpace(Insets.xl),
                            ButtonPrimary(
                              onPress: () {
                                _login(context);
                                FocusScope.of(context).unfocus();
                              },
                              label: "Masuk",
                            ),
                            verticalSpace(Insets.xl),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Belum punya akun? "),
                                InkWell(
                                  onTap: () => Get.to(() => RegisterPage()),
                                  child: Text(
                                    "Daftar",
                                    style: MyTextTheme.body1
                                        .copyWith(color: Colors.red),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ))
                ],
              ),
            ));
      }),
    );
  }
}
