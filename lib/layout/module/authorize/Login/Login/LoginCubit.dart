import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopp_app/Network/dio_helper.dart';
import 'package:shopp_app/models/loginModel.dart';

import '../../../../../shared/end-point.dart';
import 'LoginStates.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  LoginModel? login;

  void loginApp(String email, String pass) async {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': pass,
      },
    )!
        .then((value) async {
      login = LoginModel.fromJson(value?.data);
      emit(GetLoginDataSucess(login!));
    }).catchError((e) {
      if (!isClosed) {
        print(e.toString());
        emit(GetLoginDataError(e.toString()));
      }
    });
  }

  IconData icons = Icons.visibility;

  bool isShow = false;

  void changePass() {
    if (isShow) {
      icons = Icons.visibility;
      isShow = !isShow;
    } else {
      icons = Icons.visibility_off;
      isShow = !isShow;
    }
    emit(ChangeIconPass());
  }
}
