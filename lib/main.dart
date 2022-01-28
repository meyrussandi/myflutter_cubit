import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myflutter_cubit/config/themes.dart';
import 'package:myflutter_cubit/cubits/auth/auth_cubit.dart';
import 'package:myflutter_cubit/cubits/users/usergit.dart';
import 'package:myflutter_cubit/data/database/my_database.dart';
import 'package:myflutter_cubit/screen/login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiBlocProvider(

    providers: [
      BlocProvider(  create: (_) =>AuthCubit(MyDatabase.instance),),
      BlocProvider(  create: (_) =>UserGitCubit(UsersGitService()),),
    ],
    child:  MyApp()
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () {
        return GetMaterialApp(
          title: 'Flutter Demo',
          theme: appTheme,
          home:  Login()
        );
      }
    );
  }
}
