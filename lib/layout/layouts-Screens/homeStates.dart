import '../../models/categoriesModel.dart';
import '../../models/favModel.dart';
import '../../models/getFavModel.dart';
import '../../models/homeModel.dart';
import '../../models/loginModel.dart';

abstract class States {}

class InitialHomeState extends States {}

class ChangeBottomNavHome extends States {}

class GetDataHomeLoading extends States {}

class GetDataHomeSuccess extends States {
  HomeModel home ;
  GetDataHomeSuccess(this.home);
}
class GetDataHomeError extends States {
  final String error ;
  GetDataHomeError(this.error);
}

class GetCategoriesSuccess extends States {
  CategoriesModel categoriesModel ;
  GetCategoriesSuccess(this.categoriesModel);
}
class GetCategoriesError extends States {
  final String error ;
  GetCategoriesError(this.error);
}
// post fav
class GetFavSuccess extends States {}
class GetChangeFavSuccess extends States {
  FavModel favModel ;
  GetChangeFavSuccess (this.favModel);
}

class GetChangeFavError extends States {}

// getFavvv

// to use check and remove the item in the list in same sec without loading show to user
// use in post fav and get fav
class GetFavLoading extends States {}

// use in the get fav
class GetDataFavSuccess extends States {
  GetFavModel getFavModel ;
  GetDataFavSuccess(this.getFavModel);
}

class GetDataFavError extends States {}

// personal inf
class GetDataPersonalSuccess extends States {
  LoginModel loginModel ;
  GetDataPersonalSuccess(this.loginModel);
}

class GetDataPersonalError extends States {
  final String error ;

  GetDataPersonalError(this.error);

}
