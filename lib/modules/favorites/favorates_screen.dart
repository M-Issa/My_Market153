import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansour7/models/favorites_model.dart';

import '../../consts/styles/colors.dart';
import '../../shared/components/components.dart';
import '../home/cubit/shop_cubit.dart';
import '../home/cubit/shop_state.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ShopCubit cubit = ShopCubit.get(context);
          return ConditionalBuilder(
            condition: state is! ShopLoadingFavoritesDataState,
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
            builder: (context) => ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildFavoritesItem(
                    ShopCubit.get(context).favoritesModel!.data!.data![index],
                    context),
                separatorBuilder: (context, index) => myDivider(),
                itemCount:
                    ShopCubit.get(context).favoritesModel!.data!.data!.length),
          );
        });
  }

  Widget buildFavoritesItem(Data model, context) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      width: double.infinity,
      height: 140,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage('${model.product?.image}'), //***
                width: 140,
                height: 140,
              ),
              if (model.product?.discount != 0)
                Container(
                  color: Colors.red.withOpacity(.9),
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.0,
                  ),
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(fontSize: 8, color: Colors.white),
                  ),
                ),
            ],
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              //we add column for give padding to its elements
              children: [
                Text(
                  '${model.product?.name}',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    height: 1.5, //  المسافة بين السطور
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      '${model.product?.price}',
                      style: const TextStyle(
                        fontSize: 12,
                        height: 1.3,
                        color: shopPrimaryColor,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    if (model.product?.discount != 0) //********
                      Text(
                        '${model.product?.oldPrice}',
                        style: const TextStyle(
                          fontSize: 10,
                          height: 1.3,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          ShopCubit.get(context)
                              .changeFavorites(model.product!.id!);
                        },
                        icon: CircleAvatar(
                          backgroundColor: ShopCubit.get(context)
                              .favorites[model.product?.id]!
                              ? shopPrimaryColor
                              : Colors.grey,
                          radius: 16,
                          child: Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                            size: 15,
                          ),
                        )),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );

}
