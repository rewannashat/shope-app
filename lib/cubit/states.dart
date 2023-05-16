
abstract class AppStates {}

class InitialState extends AppStates {}
class AppChangeBottomNavState extends AppStates {}

class AppChangeTheme extends AppStates {}

class GetBusinessDataSucess extends AppStates {}

class GetBusinessDataError extends AppStates {
  final String error ;

  GetBusinessDataError(this.error);

}

