import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansour7/models/search_model.dart';
import 'package:mansour7/modules/search/cubit/search_cubit.dart';
import 'package:mansour7/shared/components/components.dart';

import '../../consts/styles/colors.dart';
import '../home/cubit/shop_cubit.dart';
import 'cubit/search_states.dart';

class SearchScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
  var searchController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
       child: BlocConsumer<SearchCubit,SearchStates>(
         listener: (context, state) {

         },
         builder: (context, state) {
           return Scaffold(
             appBar: AppBar(),
             body: Padding(
               padding: const EdgeInsets.all(16.0),
               child: Form(
                 key: formKey,
                 child: Column(
                   children: [
                    myFormField(
                        radius: 32,
                        controller: searchController,
                        type: TextInputType.text,
                        validate: (value){
                          if(value.isEmpty){
                            return 'The Search Field Can\'t be Empty';
                          }
                          return null;
                        },
                      onFieldSubmitted: (text){
                          SearchCubit.get(context).shopSearch(text);
                      },
                        label: 'Search',
                        prefix: Icons.search,
                    ),
                     SizedBox(
                       height: 10,
                     ),
                     if(state is SearchLodingState)
                      LinearProgressIndicator(),
                      SizedBox(height: 10,),
                      if(state is SearchSuccessState)
                      Expanded(
                       child: ListView.separated(
                           physics: BouncingScrollPhysics(),
                           itemBuilder: (context, index) => buildSearchItem(
                               SearchCubit.get(context).model!.data!.data![index],
                               context),
                           separatorBuilder: (context, index) => myDivider(),
                           itemCount:
                           SearchCubit.get(context).model!.data!.data!.length),
                     ),
                   ],
                 ),
               ),
             ),
           );
         },
       ),

    );
  }

  Widget buildSearchItem(ProductData model, context) => Padding(
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
                image: NetworkImage('${model.image}'), //***
                width: 140,
                height: 140,
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
                  '${model.name}',
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
                      '${model.price}',
                      style: const TextStyle(
                        fontSize: 12,
                        height: 1.3,
                        color: shopPrimaryColor,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),

                    Spacer(),
                    IconButton(
                        onPressed: () {

                        },
                        icon: CircleAvatar(
                          backgroundColor: Colors.blue,
                              // ? shopPrimaryColor
                              // : Colors.grey,
                          radius: 16,
                          child:Text(
                            'M',style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 18,
                          ),
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