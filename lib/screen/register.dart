import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:myflutter_cubit/config/config.dart';
import 'package:myflutter_cubit/cubits/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myflutter_cubit/models/user_model.dart';
import 'package:myflutter_cubit/utils/page_primary.dart';
import 'package:myflutter_cubit/utils/snackbar.dart';
import 'package:myflutter_cubit/widgets/buttons/button_primary.dart';
import 'package:myflutter_cubit/widgets/inputs/input_email.dart';
import 'package:myflutter_cubit/widgets/inputs/input_password.dart';
import 'package:myflutter_cubit/widgets/inputs/input_primary.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameC = TextEditingController();
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passwordC = TextEditingController();
  final TextEditingController confirmPasswordC = TextEditingController();
  final TextEditingController genderC = TextEditingController();
  bool hidePassword = true;

  _validateForm() {
    FocusScope.of(context).unfocus();

    final auth = context.read<AuthCubit>();

    if (nameC.text.isEmpty) {
      context.errorSnackbar('nama tidak boleh kosong');
    } else if (emailC.text.isEmpty) {
      context.errorSnackbar('email tidak boleh kosong');
    } else if (passwordC.text.isEmpty) {
      context.errorSnackbar('password tidak boleh kosong');
    } else if (passwordC.text != confirmPasswordC.text) {
      context.errorSnackbar('konfirmasi password tidak cocok');
    }
    // else if (genderC.text.isEmpty) {
    //   context.errorSnackbar('Pilih Jenis kelamin anda');
    // }
    else {
        auth.register(
            UserModel(name: nameC.text, email: emailC.text, gender: 'Pria'), passwordC.text);


    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, authState){
        if(authState is AuthSuccess){
          Get.back();
          context.snackbar('Success', authState.message);
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
                  Container(
                      padding: MediaQuery.of(context).viewInsets.bottom == 0
                          ? EdgeInsets.all(Insets.lg)
                          : EdgeInsets.fromLTRB(Insets.lg, Insets.lg, Insets.lg,
                              MediaQuery.of(context).viewInsets.bottom),
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height -
                            MediaQuery.of(context).viewPadding.top,
                      ),
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
                                      "Silahkan isi data anda !!!",
                                      style: MyTextTheme.body1,
                                    ),
                                    Text(
                                      "Daftar",
                                      style: MyTextTheme.heading4,
                                    ),
                                  ],
                                ),
                                IconButton(
                                    onPressed: () => Get.back(),
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.red,
                                    ))
                              ],
                            ),
                            verticalSpace(Insets.lg),
                            InputPrimary(
                              controller: nameC,
                              label: 'Nama',
                            ),
                            verticalSpace(Insets.med),
                            InputEmail(controller: emailC),
                            verticalSpace(Insets.med),
                            InputPassword(
                              controller: passwordC,
                            ),
                            verticalSpace(Insets.xl),
                            InputPassword(
                              controller: confirmPasswordC,
                            ),
                            verticalSpace(Insets.xl),
                            ButtonPrimary(
                                onPress: () {
                                  _validateForm();
                                },
                                label: 'Daftar'),
                            verticalSpace(Insets.xl),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Sudah punya akun? "),
                                InkWell(
                                  onTap: () {},
                                  child: Text(
                                    "Login",
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
