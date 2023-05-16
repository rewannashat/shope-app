import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopp_app/widget-constant/constWidget.dart';

import '../../cubit/cubit.dart';
import '../../shared/local/sharedPref.dart';
import '../module/authorize/Login/Login/login-Screen.dart';
import 'homeCubit.dart';
import 'homeStates.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    MediaQueryData media = MediaQuery.of(context);
    return BlocConsumer<HomeCubit, States>(
      listener: (context, state) => {},
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              cubit.title[cubit.currentIndex],
              style: TextStyle(
                fontSize: media.size.height * 0.03,
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    //   Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchScreen()));
                  },
                  icon: Icon(Icons.search)),
              IconButton(
                  onPressed: () {
                    AppThemeCubit.get(context).changeTheme();
                  },
                  icon: Icon(Icons.brightness_4_outlined)),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            elevation: 30,
            currentIndex: cubit.currentIndex,
            onTap: (v) {
              cubit.changeBootom(v);
            },
            items: cubit.bottom,
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}
// TextButton(
// onPressed: (){
// SharedPrefrence.clearData(key: 'Authorization')!.then((value) {
// if (value) {
// NavAndRemove(screen: const LoginScreen() , ctx: context);
// }
// });
//
// },
// child: Text('Cliccccccccck'),
// ),
