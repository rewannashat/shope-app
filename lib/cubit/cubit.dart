
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopp_app/cubit/states.dart';

import '../shared/local/sharedPref.dart';


class AppThemeCubit extends Cubit <AppStates> {
  AppThemeCubit() : super(InitialState());
    static AppThemeCubit get (context) => BlocProvider.of(context);

  bool isDark = false ;
  void changeTheme({bool? formator}) {
    if (formator != null) {
      isDark = formator ;
      emit(AppChangeTheme());
    } else if (formator == null) {
      isDark = !isDark ;
      SharedPrefrence.putBoolean('isDark' , isDark);
      emit(AppChangeTheme());
    }

  }

   }