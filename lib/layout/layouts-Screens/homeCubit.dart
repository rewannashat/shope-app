import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopp_app/Network/dio_helper.dart';
import 'package:shopp_app/layout/layouts-Screens/homeStates.dart';

import '../../models/categoriesModel.dart';
import '../../models/favModel.dart';
import '../../models/getFavModel.dart';
import '../../models/homeModel.dart';
import '../../models/loginModel.dart';
import '../../shared/end-point.dart';
import '../../style/Constant.dart';
import 'categories-Screen.dart';
import 'favorit-Screen.dart';
import 'home-Screen.dart';
import 'setting-Screen.dart';

class HomeCubit extends Cubit<States> {
  HomeCubit() : super(InitialHomeState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    HomeScreen(),
    CategoriesScreen(),
    FavoriteScreen(),
    SettingScreen(),
  ];
  List <String> title = [ 'Home' , 'Categories' , 'Favorite' , 'Setting'] ;
  List <BottomNavigationBarItem> bottom = [
    BottomNavigationBarItem(icon: Icon(Icons.home) , label: 'Home') ,
    BottomNavigationBarItem(icon: Icon(Icons.category) , label: 'Categories') ,
    BottomNavigationBarItem(icon: Icon(Icons.favorite) , label: 'Favorite') ,
    BottomNavigationBarItem(icon: Icon(Icons.settings) , label: 'Setting') ,
  ] ;

  void changeBootom (int num) {
    currentIndex = num ;
    emit(ChangeBottomNavHome());

  }
  HomeModel? homeMoedl ;
   Map<int,bool> favorite = {} ;
  void getDataHome () async{
    emit(GetDataHomeLoading());
    DioHelper.getData(url: Home , token: token).then((value) {
      homeMoedl = HomeModel.fromJson(value?.data);
      //print('Hereeeeee ${homeMoedl?.data!.banners![0].image}');
     // print('$token');
      homeMoedl!.data!.products!.forEach((element) {
        favorite.addAll({
          element.id!:element.inFavorites!});
      }) ;
     // print(favorite);
      emit(GetDataHomeSuccess(homeMoedl!));
    }).catchError((onError) {
      if (!isClosed) {
        print(onError.toString());
        emit(GetDataHomeError(onError.toString()));
      }
    });
  }

  CategoriesModel? categoriesModel;
  void getCategoriesHome () async{
    emit(GetDataHomeLoading());
    DioHelper.getData(url: Categories).then((value) {
      categoriesModel = CategoriesModel.fromJson(value?.data);
    //  print('Hereeeeee ${categoriesModel!.data!.currentPage}');
      emit(GetCategoriesSuccess(categoriesModel!));
    }).catchError((onError) {
      if (!isClosed) {
        print(onError.toString());
        emit(GetCategoriesError(onError.toString()));
      }
    });
  }

  FavModel? favModel ;
  void changeFav (int prodId) {
    // to change color of icon remotly in same sec
    favorite[prodId] = favorite[prodId] ?? false;
    favorite[prodId] = !favorite[prodId]!;
    emit(GetFavSuccess());
    DioHelper.postData(url: Favorite,
        data: {
          'product_id' : prodId ,
        } ,
      token: token,
    )!.then((value) {
      favModel = FavModel.fromJson(value?.data);
          // print(favModel!.message);
         // to check error if happen , change color then return the first state and
        // dont add to the fav
      if ( favModel!.status == false) {
        favorite[prodId] = favorite[prodId] ?? false;
        favorite[prodId] = !favorite[prodId]!;
      } else {
        // to change color and remove fav in this sec
        getFav();
      }
      emit(GetChangeFavSuccess(favModel!));
    }).catchError((onError) {
      favorite[prodId] = favorite[prodId] ?? false;
      favorite[prodId] = !favorite[prodId]!;
      emit(GetChangeFavError());
    });
  }


  GetFavModel? getFavModel ;
  void getFav () {
    emit(GetFavLoading());
    DioHelper.getData(
        url: Favorite ,
        token: token,
    ).then((value) {
      getFavModel = GetFavModel.fromJson(value?.data) ;
      emit(GetDataFavSuccess(getFavModel!));
      //print ('The Fav is hereeee ${getFavModel?.data?.data![0].id}');
    }).catchError((onError) {
      emit(GetDataFavError());
    }) ;
  }

  // getdata personal info
  LoginModel? login;
  void getPersonalInfo () {
    DioHelper.getData(
        url: Personal ,
        token: token ,
    ).then((value) {
     // print ('the personal info is');
      login = LoginModel.fromJson(value!.data);
    //  print ('the personal info is : ${login!.data!.name}');
      emit(GetDataPersonalSuccess(login!));
    }).catchError((onError) {
      emit(GetDataPersonalError(onError.toString()));
      print(onError);
    });
}
}
