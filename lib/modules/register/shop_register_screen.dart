import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansour7/modules/Register/cubit/shop_Register_state.dart';
import 'package:mansour7/modules/register/cubit/shop_register_cubit.dart';

import '../../consts/constant.dart';
import '../../shared/components/components.dart';
import '../../shared/components/text_button.dart';
import '../../shared/local/cash_helper.dart';
import '../home/shop_layout_screen.dart';

class ShopRegisterScreen extends StatelessWidget {
  //change types from var to final.....
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.registerModel.status ?? false) {
              print(state.registerModel.message);
              print(state.registerModel.data?.token);
              CashHelper.saveData(
                key: 'token',
                value: state.registerModel.data?.token,
              ).then((value) {
                navigateAndFinish(context, ShopLayoutScreen());
                token = state.registerModel.data!.token!; ////اجتهاد شخصي 👌👌👌
              });
            } else {
              print(state.registerModel.status);
              showToast(
                  text: '${state.registerModel.message}',
                  state: ToastState.ERROR);
            }
          }
        },
        builder: (context, state) {
          ShopRegisterCubit cubit = ShopRegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register'.toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        myFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'please enter your full name';
                            }
                            return null;
                          },
                          label: 'Enter your full name',
                          prefix: Icons.person,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        myFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'please enter your email address';
                            }
                            return null;
                          },
                          label: 'Enter your email',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        myFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'please enter your password';
                              }
                              return null;
                            },
                            label: 'Enter your password',
                            prefix: Icons.lock_open_outlined,
                            obscure: cubit.isPassword,
                            suffix: cubit.suffix,
                            suffixPressed: () {
                              cubit.changeIconVisibility();
                            }),
                        const SizedBox(
                          height: 16.0,
                        ),
                        myFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'please enter your phone';
                            }
                            return null;
                          },
                          label: 'Enter your phone',
                          prefix: Icons.phone,
                        ),
                        const SizedBox(
                          height: 24.0,
                        ),
                        ConditionalBuilder(
                          builder: (context) => myButton(
                              text: 'Register'.toUpperCase(),
                              fontSize: 18,
                              radius: 16,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.userRegister(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              }),
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          condition: state is! ShopRegisterLodingState,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
