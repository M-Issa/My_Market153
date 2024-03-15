import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansour7/models/categories_model.dart';
import 'package:mansour7/models/home_model.dart';
import 'package:mansour7/modules/home/cubit/shop_cubit.dart';
import 'package:mansour7/modules/home/cubit/shop_state.dart';
import 'package:mansour7/shared/components/components.dart';
import '../../consts/constant.dart';
import '../../consts/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is ShopSuccessChangeFavoritesDataState){
          if(!state.model.status!){
            showToast(state:ToastState.ERROR, text: state.model.message!);
          }
        }
      },
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categoriesModel != null,
          //this condition modified after building categoriesModel
          builder: (context) =>
              builderWidget(cubit.homeModel!, cubit.categoriesModel!,context),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
  //function to build all screen
  Widget builderWidget(
          HomeModel model, CategoriesModel categoriesModel,BuildContext context) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model.data?.banners
                  .map((e) => Image(
                        image: NetworkImage('${e.image}'),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 250,
                initialPage: 0,
                viewportFraction: 1.0, //عرض الصورة في الشاشة
                enableInfiniteScroll: true, //for always move
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(
                  seconds: 3,
                ),
                autoPlayAnimationDuration: const Duration(
                  seconds: 1,
                ),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              // the Padding and Column for padding these
              // elemets for 10 from edge of screen
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Container(
                    height: 100,
                    //wrap listView in container for sized it and avoid errors
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          buildCategoryItem(categoriesModel.data!.data[index],context),
                      separatorBuilder: (context, index) => SizedBox(
                        width: 10,
                      ),
                      itemCount: categoriesModel.data!.data.length,
                    ),
                  ),
                  Text(
                    'New Products',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.white,
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 1,
                childAspectRatio: 1 / 1.7, //نسبة الطول إلى العرض
                children: List.generate(
                  model.data!.products.length,
                  (index) =>
                      buildGridProductItem(model.data!.products[index], context),
                ),
              ),
            ),
          ],
        ),
      );
  // fuction to build product Item
  Widget buildGridProductItem(ProductModel model,context) => Container(
    color: Colors.white,
    child: Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage('${model.image}'), //***
              width: double.infinity,
              height: 200,
            ),
            if (model.discount != 0)
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
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            //we add column for give padding to its elements
            children: [
              Text(
                '${model.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.3, //  المسافة بين السطور
                ),
              ),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    style: const TextStyle(
                      fontSize: 12,
                      height: 1.3,
                      color: shopPrimaryColor,
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  if (model.discount != 0) //********
                    Text(
                      '${model.oldPrice.round()}',
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
                        ShopCubit.get(context).changeFavorites(model.id!);
                        print(ShopCubit.get(context).favorites);
                        print(model.id);
                        print(token);
                      },
                      icon: CircleAvatar(
                        backgroundColor:
                        ShopCubit.get(context).favorites[model.id]!
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
  );
  Widget buildCategoryItem(DataModel model,context) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage('${model.image}'),
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(.8),
            width: 100,
            child: Text(
              '${model.name}',
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
}
