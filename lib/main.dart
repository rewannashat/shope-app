import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:shopp_app/layout/layouts-Screens/home.dart';
import 'package:shopp_app/shared/bloc_observer.dart';
import 'package:shopp_app/shared/local/sharedPref.dart';
import 'package:shopp_app/style/Constant.dart';

import 'Network/dio_helper.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'layout/layouts-Screens/homeCubit.dart';
import 'layout/module/authorize/Login/Login/login-Screen.dart';
import 'layout/onboarding-Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  await SharedPrefrence.init();
  await ScreenUtil.ensureScreenSize();
  token = SharedPrefrence.getData(key: 'Authorization');
  //bool? isFormate = SharedPref.getData('isDark');
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  late var boaeding = SharedPrefrence.getData(key: 'OnBoarding');

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppThemeCubit()..changeTheme(),),
        BlocProvider(create: (context) => HomeCubit()..getDataHome()..getCategoriesHome()..getFav()..getPersonalInfo(),),
      ],
      child: BlocConsumer<AppThemeCubit, AppStates>(
        listener: (context, state) => {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: AppThemeCubit.get(context).isDark? ThemeMode.light : ThemeMode.dark,
            home:screen(),
          );
        },
      ),
    );

  }
  Widget? screen ()  {
    if (boaeding == false || boaeding == null ) {
      return onBoardingScreen() ;
    } else if (boaeding == true ) {
      if (token != null ) {
        return HomeLayout();
      } else {
        return LoginScreen();
      }
    }
    return null;
  }


}