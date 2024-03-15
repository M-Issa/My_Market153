import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mansour7/consts/constant.dart';
import 'package:mansour7/modules/home/shop_layout_screen.dart';
import 'package:mansour7/modules/login/cubit/shop_login_cubit.dart';
import 'package:mansour7/modules/login/cubit/shop_login_state.dart';
import 'package:mansour7/shared/local/cash_helper.dart';
import '../../shared/components/components.dart';
import '../../shared/components/text_button.dart';
import '../register/shop_register_screen.dart';

class ShopLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
          listener: (context, state) => {
                if (state is ShopLoginSuccessState)
                  {
                    if (state.loginModel.status ?? false)
                      {
                        print(state.loginModel.message),
                        print(state.loginModel.data?.token),
                        CashHelper.saveData(
                          key: 'token',
                          value: state.loginModel.data?.token,
                        ).then((value) {
                          navigateAndFinish(context, ShopLayoutScreen());
                          token = state
                              .loginModel.data!.token!; ////اجتهاد شخصي 👌👌👌
                        })
                      }
                    else
                      {
                        print(state.loginModel.status),
                        showToast(
                            text: '${state.loginModel.message}',
                            state: ToastState.ERROR),
                      }
                  }
              },
          builder: (context, state) {
            ShopLoginCubit cubit = ShopLoginCubit.get(context);
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
                            'LOGIN',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Login now to browse our hot offers',
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
                          const SizedBox(
                            height: 15.0,
                          ),
                          myFormField(
                              //submit will login after ending password enter
                              onFieldSubmitted: (String? value) {
                                if (formKey.currentState!.validate()) {
                                  cubit.userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
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
                            height: 40.0,
                          ),
                          ConditionalBuilder(
                            builder: (context) => myButton(
                              radius: 16,
                                text: 'LOGIN',
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.userLogin(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                }),
                            fallback: (context) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            condition: state is! ShopLoginLodingState,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Dont\'t have an account?'),
                              MyTextButton(
                                  text: 'register now',
                                  onPressed: () {
                                    navigateTo(
                                        context,  ShopRegisterScreen());
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
