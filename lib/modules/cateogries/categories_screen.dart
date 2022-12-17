import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/layout/cubit/cubit.dart';
import 'package:shopping_app/layout/cubit/states.dart';
import 'package:shopping_app/modules/category_products/category_products_screen.dart';
import 'package:shopping_app/shared/components/components.dart';


class CategoriesScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        return ShopCubit.get(context).categoriesModel !=null ? ListView.separated(
          itemBuilder: (context, index) => buildCatItem(ShopCubit.get(context).categoriesModel!.data!.data![index],context),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: ShopCubit.get(context).categoriesModel!.data!.data!.length,
        ): Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildCatItem(model,context) => InkWell(
    onTap: (){
      ShopCubit.get(context).getCategoriesDetailData(model.id);
      navigateTo(context, CategoryProductsScreen());
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children:
        [
          Image(
            image: NetworkImage(model.image!),
            width: 80.0,
            height: 80.0,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 20.0,
          ),
          Text(model.name!,
            style: Theme.of(context).textTheme.bodyText1,),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
          ),
        ],
      ),
    ),
  );
}