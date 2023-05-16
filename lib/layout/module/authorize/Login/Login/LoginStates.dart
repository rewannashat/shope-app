import '../../../../../models/loginModel.dart';

abstract class LoginStates {}

class InitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class GetLoginDataSucess extends LoginStates {
  final LoginModel login ;

  GetLoginDataSucess(this.login);
}

class GetLoginDataError extends LoginStates {
  final String error ;

  GetLoginDataError(this.error);

}

class ChangeIconPass extends LoginStates {}