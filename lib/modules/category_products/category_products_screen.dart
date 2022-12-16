import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/layout/cubit/cubit.dart';
import 'package:shopping_app/layout/cubit/states.dart';
import 'package:shopping_app/modules/product_details/product_details_screen.dart';
import 'package:shopping_app/shared/components/components.dart';
import 'package:shopping_app/shared/styles/colors.dart';

class CategoryProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
              appBar: AppBar(),
            body: ShopCubit.get(context).categoryProductsModel != null ?
            ListView.separated(
                itemBuilder: (context,index)=>buildItem(ShopCubit.get(context).categoryProductsModel!.data!.data![index],context),
                separatorBuilder:(context,index)=> myDivider(),
                itemCount: ShopCubit.get(context).categoryProductsModel!.data!.data!.length,
            ) : Center(child: CircularProgressIndicator()),
          );
        }
    );
  }
  Widget buildItem(model,context)=>InkWell(
    onTap: (){
      ShopCubit.get(context).getProductData(model.id);
      navigateTo(context, productDetailsScreen());
    },
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 120.0,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image!),
                  fit: BoxFit.cover, // bymot el image alashan takhod el width wel hight
                  width: 120.0,
                  height: 120.0,
                ),
                if (model.discount != 0)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text('DISCOUNT',
                      style: TextStyle(
                        fontSize: 8.0,
                        color: Colors.white,
                      ),
                    ),
                  )
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model.name!,
                    maxLines: 3,
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
                      if (model.discount != 0)
                        Text(
                          '${model.oldPrice.round()}',
                           style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id!);
                        },
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor: ShopCubit.get(context).favorites[model.id]! ? defaultColor : Colors.grey,
                          child: Icon(
                            Icons.favorite_border,
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
