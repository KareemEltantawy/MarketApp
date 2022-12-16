import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/layout/cubit/states.dart';
import 'package:shopping_app/models/categories_model.dart';
import 'package:shopping_app/models/category_products_model.dart';
import 'package:shopping_app/models/change_favorites_model.dart';
import 'package:shopping_app/models/favorites_model.dart';
import 'package:shopping_app/models/home_model.dart';
import 'package:shopping_app/models/login_model.dart';
import 'package:shopping_app/models/product_details_model.dart';
import 'package:shopping_app/models/search_model.dart';
import 'package:shopping_app/modules/cateogries/categories_screen.dart';
import 'package:shopping_app/modules/favorites/favorites_screen.dart';
import 'package:shopping_app/modules/home/home_screen.dart';
import 'package:shopping_app/modules/profile/profile_screen.dart';
import 'package:shopping_app/shared/components/constants.dart';
import 'package:shopping_app/shared/network/end_points.dart';
import 'package:shopping_app/shared/network/remote/dio_helper.dart';


class ShopCubit extends Cubit<ShopStates> {

  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    HomeScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }


  HomeModel? homeModel;
  Map<int, bool> favorites = {};
  //call it in the main
  void getHomeData() {
    DioHelper.getData(  // as the type of the api in post man is get
      url: HOME,
      token: token,   // look at headers in post man you will find authurization(token),,lang and content-type will take defult values(look at getData function)
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      homeModel!.data!.products!.forEach((element) {// we add this to color products that has in_favorites=true in the api
        favorites.addAll({
          element.id!: element.inFavorites!,
        });
      });

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }


  CategoriesModel? categoriesModel;
  //call it in the main
  void getCategories() {
    DioHelper.getData(
      url: CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }



  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId) {
    // to change the button color in the same moment we click
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoritesState()); //note we make this additional class in states file
    //
    DioHelper.postData(
      url: FAVORITES,
      data: {         // the body in the api in postman
        'product_id': productId, // astabel el productId fe ()  el function
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      // to change the button color in the same moment we click
      if (!changeFavoritesModel!.status!) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavorites();
      }
      //
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      // to change the button color in the same moment we click
      favorites[productId] = !favorites[productId]!;
      //
      print(error.toString());
      emit(ShopErrorChangeFavoritesState());
    });
  }





  FavoritesModel? favoritesModel;
  //call it in the main
  void getFavorites() {
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }




  LoginModel? userModel;
  //call it in the main
  void getUserData() {
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      emit(ShopSuccessUserDataState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }


  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
      token: token,
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      emit(ShopSuccessUpdateUserState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }


  CategoryProductsModel? categoryProductsModel;
  void getCategoriesDetailData(int categoryID){
    categoryProductsModel=null; //we write it to clear categoriesProductsModel from data that it gain when we call this function from anther category
    DioHelper.getData(
        url: PRODUCTS,
        query: {                // look at postman what is next ? in the link is the query
          'category_id':categoryID,
        },
      token: token,
    ).then((value) {
      categoryProductsModel = CategoryProductsModel.fromJson(value.data);

      categoryProductsModel!.data!.data!.forEach((element) {  // we write it in getHomeData() function and we write it again her as there are items in the categories products and they arent in the products that are in the home
        if(!favorites.containsKey(element.id!)){
          favorites.addAll({element.id!: element.inFavorites!});
        }
      });

      emit(CategoryProductsSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(CategoryProductsErrorState());
    });
  }



  ProductDetailsModel? productDetailsModel;
  void getProductData(int productId ) {
    productDetailsModel = null;//we write it to clear productDetailsModel from data that it gain when we call this function from anther product
    DioHelper.getData(
        url: 'products/$productId',
        token: token,
    ).then((value){
      productDetailsModel = ProductDetailsModel.fromJson(value.data);
      emit(ProductSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(ProductErrorState());
    });
  }


  SearchModel? searchmodel;
  void search(String text) {
    DioHelper.postData(
      url: SEARCH,
      data: {
        'text': text,
      },
      token: token,
    ).then((value)
    {
      searchmodel = SearchModel.fromJson(value.data);

      searchmodel!.data!.data!.forEach((element) {  // we write it in getHomeData() function and we write it again her as there are items in the search and they arent in the products that are in the home
        if(!favorites.containsKey(element.id!)){
          favorites.addAll({element.id!: element.inFavorites!});
        }
      });

      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }



}



