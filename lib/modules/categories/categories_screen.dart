import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansour7/models/categories_model.dart';
import 'package:mansour7/shared/components/components.dart';

import '../home/cubit/shop_cubit.dart';
import '../home/cubit/shop_state.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ShopCubit cubit=ShopCubit.get(context);
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildCategoryItem(cubit.categoriesModel!.data!.data[index]),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: cubit.categoriesModel!.data!.data.length);
        }
    );
  }

 Widget buildCategoryItem(DataModel data)=>Padding(
   padding: const EdgeInsets.all(16.0),
   child: Row(
     children: [
       Image(
         image:NetworkImage('${data.image}',),
         width: 140,
         height:140,
       ),
       SizedBox(width: 20,),
       Expanded(
         child: Text('${data.name}',overflow: TextOverflow.ellipsis,maxLines: 2,
           style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
         ),
       ),
       Spacer(),
       Icon(Icons.arrow_forward_ios),
     ],
   ),
 );

}
