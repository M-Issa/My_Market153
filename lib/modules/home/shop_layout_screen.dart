import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansour7/consts/styles/colors.dart';
import 'package:mansour7/modules/home/cubit/shop_cubit.dart';
import 'package:mansour7/modules/home/cubit/shop_state.dart';
import 'package:mansour7/modules/search/search_screen.dart';
import 'package:mansour7/shared/components/components.dart';

class ShopLayoutScreen extends StatelessWidget {
  const ShopLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return Scaffold(
          // appBar: AppBar(),
          appBar: AppBar(
            title: Text(
                'My Salla',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: shopPrimaryColor,
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  },
                  icon: Icon(Icons.search)),
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.items,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeNavBarIndex(index);
            },
          ),
        );
      },
    );
  }
}
