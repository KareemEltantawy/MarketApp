import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/layout/cubit/cubit.dart';
import 'package:shopping_app/layout/cubit/states.dart';
import 'package:shopping_app/modules/product_details/product_details_screen.dart';
import 'package:shopping_app/shared/components/components.dart';
import 'package:shopping_app/shared/styles/colors.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  defaultFormField(
                    controller: searchController,
                    type: TextInputType.text,
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'enter text to search';
                      }
                      return null;
                    },
                    onChange: (value) {
                      ShopCubit.get(context).search(value);
                    },
                    label: 'Search',
                    prefix: Icons.search,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  if (ShopCubit.get(context).searchmodel != null)
                    Expanded( //note you must put ListView in Expanded becouse the body not  listview direct but consist of column contain formfield and ListView
                      child: ListView.separated(
                        itemBuilder: (context, index) => buildLisProduct(ShopCubit.get(context).searchmodel!.data!.data![index], context),
                        separatorBuilder: (context, index) => myDivider(),
                        itemCount: ShopCubit.get(context).searchmodel!.data!.data!.length,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildLisProduct(model, context) => InkWell(
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
                Image(
                  image: NetworkImage(model.image),
                  width: 120.0,
                  height: 120.0,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(model.name,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Spacer(),
                      Row(
                          children:[
                        Text('${model.price}',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: defaultColor,
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
                      ]
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
