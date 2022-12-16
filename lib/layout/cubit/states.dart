import 'package:shopping_app/models/change_favorites_model.dart';
import 'package:shopping_app/models/login_model.dart';

abstract class ShopStates {}
class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}
class ShopErrorHomeDataState extends ShopStates {}

class ShopSuccessCategoriesState extends ShopStates {}
class ShopErrorCategoriesState extends ShopStates {}

class ShopChangeFavoritesState extends ShopStates {}
class ShopSuccessChangeFavoritesState extends ShopStates
{
  final ChangeFavoritesModel changeFavoritesModel;
  ShopSuccessChangeFavoritesState(this.changeFavoritesModel);
}
class ShopErrorChangeFavoritesState extends ShopStates {}


class ShopSuccessGetFavoritesState extends ShopStates {}
class ShopErrorGetFavoritesState extends ShopStates {}


class ShopSuccessUserDataState extends ShopStates
{
  final LoginModel userModel;
  ShopSuccessUserDataState(this.userModel);
}
class ShopErrorUserDataState extends ShopStates {}


class ShopLoadingUpdateUserState extends ShopStates {}
class ShopSuccessUpdateUserState extends ShopStates
{
  final LoginModel userModel;
  ShopSuccessUpdateUserState(this.userModel);
}
class ShopErrorUpdateUserState extends ShopStates {}

class CategoryProductsSuccessState extends ShopStates{}
class CategoryProductsErrorState extends ShopStates{}

class ProductSuccessState extends ShopStates{}
class ProductErrorState extends ShopStates{}

class SearchSuccessState extends ShopStates {}
class SearchErrorState extends ShopStates {}