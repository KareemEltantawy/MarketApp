import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/layout/cubit/cubit.dart';
import 'package:shopping_app/layout/cubit/states.dart';
import 'package:shopping_app/modules/category_products/category_products_screen.dart';
import 'package:shopping_app/modules/product_details/product_details_screen.dart';
import 'package:shopping_app/shared/components/components.dart';
import 'package:shopping_app/shared/styles/colors.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      builder: (context, state) {
        return (ShopCubit.get(context).homeModel != null &&
                ShopCubit.get(context).categoriesModel != null)
            ? SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider(
                      items: ShopCubit.get(context).homeModel!.data!.banners!.map((e) => Image(
                                image: NetworkImage(e.image!),
                                fit: BoxFit.cover,
                                width: double.infinity,
                              )).toList(),
                      options: CarouselOptions(
                        height: 200,
                        viewportFraction: 1.0, //to make image take all the screen width
                        autoPlay: true, //alashan ylef ala tol
//                  autoPlayInterval: Duration(seconds: 3),
//                  autoPlayAnimationDuration: Duration(seconds: 1),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text('Categories',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      height: 100.0,
                      padding: EdgeInsets.symmetric(horizontal: 10.0) ,
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => buildCategoryItem(ShopCubit.get(context).categoriesModel!.data!.data![index],context),
                        separatorBuilder: (context, index) => SizedBox(width: 10.0),
                        itemCount: ShopCubit.get(context).categoriesModel!.data!.data!.length,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text('New Products',
                          style: Theme.of(context).textTheme.bodyText2),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    GridView.count(
                      shrinkWrap: true, // lAn hatet GridView fe SingleChildScrollView
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 1.0,// el masafa ben item el gridView ofoky
                      mainAxisSpacing: 1.0, // el masafa ben item el gridView rasy
                      childAspectRatio: MediaQuery.of(context).size.width/630,
//                      childAspectRatio: 1 / 1.59, // alard / altol
                      children: List.generate(
                        ShopCubit.get(context).homeModel!.data!.products!.length,
                        (index) => buildGridProduct(ShopCubit.get(context).homeModel!.data!.products![index], context),
                      ),
                    ),
                  ],
                ),
              ) : Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildCategoryItem(model,context) => InkWell(
    onTap: (){
      ShopCubit.get(context).getCategoriesDetailData(model.id);
      navigateTo(context, CategoryProductsScreen());
    },
    child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Image(
              image: NetworkImage(model.image!),
              height: 100.0,
              width: 100.0,
              fit: BoxFit.cover,// bymel zoom ll image alashan takhod el width wel hight
            ),
            Container(
              color: Colors.black.withOpacity(.6),
              width: 100.0,
              child: Text(model.name!,
                textAlign:TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
  );

  Widget buildGridProduct(model, context) => InkWell(
    onTap: (){
      print(model.id);
      ShopCubit.get(context).getProductData(model.id);
      navigateTo(context, productDetailsScreen());
    },
    child: Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model.image!),
              fit: BoxFit.fill, // bymot el image alashan takhod el width wel hight
              width: double.infinity,
              height: 200.0,
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
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(model.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Row(
                children: [
                  Text('${model.price.round()}',
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
  );
}
