import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/layout/cubit/cubit.dart';
import 'package:shopping_app/layout/cubit/states.dart';
import 'package:shopping_app/shared/styles/colors.dart';

class productDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: ShopCubit.get(context).productDetailsModel != null ? SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Image(
                        image: NetworkImage(ShopCubit.get(context).productDetailsModel!.data!.image!),
                        height: 300,
                        width: double.infinity,
                        fit: BoxFit.cover,
                       ),
                    if (ShopCubit.get(context).productDetailsModel!.data!.discount != 0)
                      Container(
                        color: Colors.red,
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text('DISCOUNT',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.white,
                          ),
                        ),
                      )
                  ],
                ),
                
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Text('${ShopCubit.get(context).productDetailsModel!.data!.price}',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: defaultColor,
                        ),),
                      SizedBox(
                        width: 15.0,
                      ),
                      if(ShopCubit.get(context).productDetailsModel!.data!.discount != 0)
                        Text('${ShopCubit.get(context).productDetailsModel!.data!.oldPrice}',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(ShopCubit.get(context).productDetailsModel!.data!.id!);
                        },
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor: ShopCubit.get(context).favorites[ShopCubit.get(context).productDetailsModel!.data!.id]! ? defaultColor : Colors.grey,
                          child: Icon(
                            Icons.favorite_border,
                            size: 14.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('${ShopCubit.get(context).productDetailsModel!.data!.description}',
                  style: Theme.of(context).textTheme.bodyText1,),
                )
              ],
            ),
          ) : Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
