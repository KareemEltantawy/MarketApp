import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/models/login_model.dart';
import 'package:shopping_app/modules/register/cubit/states.dart';
import 'package:shopping_app/shared/network/end_points.dart';
import 'package:shopping_app/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  })
  {
    emit(ShopRegisterLoadingState());

    DioHelper.postData(   // as the type of the api in post man is post
      url: REGISTER,
      data: {   // the body in the api in post man
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then((value)
    {
      loginModel = LoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(loginModel!));
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }


  bool isPassword = true;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    emit(ShopRegisterChangePasswordVisibilityState());
  }
}
