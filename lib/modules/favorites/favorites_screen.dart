import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/layout/cubit/cubit.dart';
import 'package:shopping_app/layout/cubit/states.dart';
import 'package:shopping_app/modules/product_details/product_details_screen.dart';
import 'package:shopping_app/shared/components/components.dart';
import 'package:shopping_app/shared/styles/colors.dart';


class FavoritesScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessChangeFavoritesState) {
          if (!state.changeFavoritesModel.status!) {
            showToast(
              msg: state.changeFavoritesModel.message!,
              backgroundColor: Colors.red,
            );
          }
        }
      },
      builder: (context, state)
      {
        return ShopCubit.get(context).favoritesModel != null ? ListView.separated(
          itemBuilder: (context, index) => buildListProduct(ShopCubit.get(context).favoritesModel!.data!.data![index].product, context),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: ShopCubit.get(context).favoritesModel!.data!.data!.length,
        ):  Center(child: CircularProgressIndicator());
      },
    );
  }
  Widget buildListProduct(model, context) =>
      InkWell(
        onTap: (){
          ShopCubit.get(context).getProductData(model.id);
          navigateTo(context, productDetailsScreen());
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            height: 120.0,
            child: Row(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Image(
                      image: NetworkImage(model.image),
                      width: 120.0,
                      height: 120.0,
                    ),
                    if (model.discount != 0)
                      Container(
                        color: Colors.red,
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.0,
                        ),
                        child: Text(
                          'DISCOUNT',
                          style: TextStyle(
                            fontSize: 8.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(model.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Text('${model.price}',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: defaultColor,
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          if (model.discount != 0 )
                            Text('${model.oldPrice}',
                              style: TextStyle(
                                fontSize: 10.0,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              ShopCubit.get(context).changeFavorites(model.id);
                            },
                            icon: CircleAvatar(
                              radius: 15.0,
                              backgroundColor: defaultColor,
//                            backgroundColor: ShopCubit.get(context).favorites[model.id]! ? defaultColor : Colors.grey,
                              child: Icon(Icons.favorite_border,
                                size: 14.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}