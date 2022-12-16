import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/models/login_model.dart';
import 'package:shopping_app/modules/login/cubit/states.dart';
import 'package:shopping_app/shared/network/end_points.dart';
import 'package:shopping_app/shared/network/remote/dio_helper.dart';


class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
  })
  {
    emit(ShopLoginLoadingState());
    DioHelper.postData(    // as the type of the api in post man is post
      url: LOGIN,
      data: {   // the body in the api in post man
        'email': email, // astabel el email fe ()  el function
        'password': password, // astabel el password fe ()  el function
      },
    ).then((value)
    {
      loginModel = LoginModel.fromJson(value.data);
      emit(ShopLoginSuccessState(loginModel!));
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }


  bool isPassword = true;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    emit(ShopChangePasswordVisibilityState());
  }
}
