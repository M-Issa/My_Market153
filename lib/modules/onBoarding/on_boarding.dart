import 'package:flutter/material.dart';
import 'package:mansour7/shared/components/components.dart';
import 'package:mansour7/shared/components/text_button.dart';
import 'package:mansour7/shared/local/cash_helper.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../consts/styles/colors.dart';
import '../../models/on_board_model.dart';
import '../login/shop_login_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  List<OnBoardModel> boarding = [
    OnBoardModel(
        image: 'assets/images/on_board3.png',
        title: 'OnBoard1',
        body: 'OnBoard1 body'),
    OnBoardModel(
        image: 'assets/images/on_board4.png',
        title: 'OnBoard2',
        body: 'OnBoard2 body'),
    OnBoardModel(
        image: 'assets/images/on_board5.png',
        title: 'OnBoard3',
        body: 'OnBoard3 body'),
  ];
  var pageController = PageController();
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        MyTextButton(
          text: 'skip',
          onPressed: () {
            CashHelper.saveData( key: 'onBoarding',value: true).then((value) {
              if(value){
              navigateAndFinish(context, ShopLoginScreen());
            }});
          })

      ],),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
                child: PageView.builder(
              physics: BouncingScrollPhysics(),
              controller: pageController,
              onPageChanged: (index) {
                if (index == boarding.length - 1) {
                  print('Last page');
                  isLast = true;
                } else {
                  print('not last');
                  isLast = false;
                }
              },
              itemBuilder: (context, index) =>
                  buildBoardingItem(boarding[index]),
              itemCount: boarding.length,
            )),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 3,
                    //تمدد النقطة المختارة
                    spacing: 10,
                    activeDotColor: shopPrimaryColor,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      CashHelper.saveData( key: 'onBoarding',value: true).then((value) {
                        if(value){
                          navigateAndFinish(context, ShopLoginScreen());
                          print('onBoarding in onScreen is $value');
                        }});
                    } else {
                      pageController.nextPage(
                        duration: Duration(
                          microseconds: 750,
                        ),
                        curve: Curves.fastEaseInToSlowEaseOut,
                      );
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios, grade: 4.2),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(OnBoardModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Image(
            image: AssetImage('${model.image}',),
          )),
          Text(
            '${model.title}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text('${model.body}'),
          SizedBox(
            height: 20,
          ),
        ],
      );
}
