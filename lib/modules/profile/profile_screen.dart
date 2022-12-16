import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/layout/cubit/cubit.dart';
import 'package:shopping_app/layout/cubit/states.dart';
import 'package:shopping_app/modules/login/shop_login_screen.dart';
import 'package:shopping_app/shared/components/components.dart';
import 'package:shopping_app/shared/network/local/cache_helper.dart';

class ProfileScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {

        if(ShopCubit.get(context).userModel != null){
          nameController.text = ShopCubit.get(context).userModel!.data!.name!;
          phoneController.text =ShopCubit.get(context).userModel!.data!.phone!;
          emailController.text = ShopCubit.get(context).userModel!.data!.email!;
        }

        return ShopCubit.get(context).userModel != null ? SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children:
                [
                  if(state is ShopLoadingUpdateUserState)
                    LinearProgressIndicator(),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'name must not be empty';
                      }
                      return null;
                    },
                    label: 'Name',
                    prefix: Icons.person,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'email must not be empty';
                      }
                      return null;
                    },
                    label: 'Email Address',
                    prefix: Icons.email,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'phone must not be empty';
                      }
                      return null;
                    },
                    label: 'Phone',
                    prefix: Icons.phone,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                    function: ()
                    {
                      if(formKey.currentState!.validate())
                      {
                        ShopCubit.get(context).updateUserData(
                          name: nameController.text,
                          phone: phoneController.text,
                          email: emailController.text,
                        );
                      }
                    },
                    text: 'update',
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                    function: () {
                      CacheHelper.removeData(
                        key: 'token',
                      ).then((value)
                      {
                        if (value)
                        {
                          navigateAndFinish(context, ShopLoginScreen());
                        }
                      });
                    },
                    text: 'Logout',
                  ),
                ],
              ),
            ),
          ),
        ) : Center(child: CircularProgressIndicator());
      },
    );
  }
}
