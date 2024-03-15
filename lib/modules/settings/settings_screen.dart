import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansour7/consts/constant.dart';
import 'package:mansour7/modules/home/cubit/shop_cubit.dart';
import 'package:mansour7/modules/home/cubit/shop_state.dart';

import '../../shared/components/components.dart';
import '../../shared/local/cash_helper.dart';
import '../login/shop_login_screen.dart';

class SettingsScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit =ShopCubit.get(context);
          var model=ShopCubit.get(context).userModel;
          nameController.text=model!.data!.name!;
          emailController.text=model.data!.email!;
          passwordController.text=pass;
          phoneController.text=model.data!.phone!;
          return ConditionalBuilder(
            condition: ShopCubit.get(context).userModel !=null,
           fallback: (context) => Center(child: CircularProgressIndicator()),
           builder: (context) => Padding(
             padding: const EdgeInsets.all(20.0),
             child: SingleChildScrollView(
               child: Form(
                 key: formKey,
                 child: Container(
                   child: Column(
                     children: [
                       Text(
                         'My Informations'.toUpperCase(),
                         style: TextStyle(
                           color: Colors.cyan,
                           fontSize: 24,
                           fontWeight: FontWeight.w500,
                         ),),
                       SizedBox(
                         height: 20,
                       ),
                       if(state is ShopLoadingUpdateProfileDataState)
                         LinearProgressIndicator(),
                       SizedBox(
                         height: 20,
                       ),
                       myFormField(
                         //enabled: false,
                         controller: nameController,
                         type: TextInputType.name,
                         validate: (value) {
                           if (value.isEmpty) {
                             return 'please enter your name';
                           }
                           return null;
                         },
                         label: 'Name',
               
                         prefix: Icons.person,
                       ),
                       SizedBox(
                         height: 20,
                       ),
                       myFormField(
                        // enabled: false,
                         controller: emailController,
                         type: TextInputType.emailAddress,
                         validate: (value) {
                           if (value.isEmpty) {
                             return 'please enter your Email';
                           }
                           return null;
                         },
                         label: 'Email',
                         prefix: Icons.email,
                       ),
                       SizedBox(
                         height: 20,
                       ),
                       myFormField(
                        // enabled: false,
                         controller: passwordController,
                         type: TextInputType.visiblePassword,
                         validate: (value) {
                           if (value.isEmpty) {
                             return 'please enter your Password ';
                           }
                           return null;
                         },
                         label: 'Password',
                         prefix: Icons.password,
                         obscure: cubit.isPassword,
                         suffix: cubit.suffix,
                         suffixPressed: (){
                           cubit.changeIconVisibility();
                         }
                       ),
                       SizedBox(
                         height: 20,
                       ),
                       myFormField(
                         //enabled: false,
                         controller: phoneController,
                         type: TextInputType.phone,
                         validate: (value) {
                           if (value.isEmpty) {
                             return 'please enter your Phone Number ';
                           }
                           return null;
                         },
                         label: 'Phone',
                         prefix: Icons.phone,
                       ),
                       SizedBox(
                         height: 20,
                       ),
                       myButton(
                           radius: 10,
                           onPressed: () {
                             if(formKey.currentState!.validate()){
                               ShopCubit.get(context).updateUserData(
                                 name: nameController.text,
                                 email:emailController.text,
                                 phone: phoneController.text,
                               );
                             }
                           },
                           text: 'UPDATE'),
                       SizedBox(
                         height: 20,
                       ),
                       myButton(
                           radius: 10,
                           onPressed: () {
                             signOut(context);
                           },
                           text: 'LOGOUT'),
                     ],
                   ),
                 ),
               ),
             ),
           ),
          );
        });
  }

  void signOut(context) {
    CashHelper.clearData(key: 'token').then((value) {
      if (value) {
        navigateAndFinish(context, ShopLoginScreen());
      }
    });
  }
}
