import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';



import '../shared/local/sharedPref.dart';
import '../style/Constant.dart';
import '../style/custom_text.dart';
import '../widget-constant/constWidget.dart';
import 'module/authorize/Login/Login/login-Screen.dart';


class onBoardingScreen extends StatefulWidget {
  const onBoardingScreen({Key? key}) : super(key: key);

  @override
  _onBoardingScreenState createState() => _onBoardingScreenState();
}

class _onBoardingScreenState extends State<onBoardingScreen> {
  PageController controller = PageController();
  int num = 3 ;
  bool last = false ;
  List<Widget> pages = [
    Colu('assets/images/board.jpg','The First View !'),
    Colu('assets/images/board.jpg','The Second View !'),
    Colu('assets/images/board.jpg','The Third View !'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView.builder(
          onPageChanged: (value) {
            if (value == pages.length -1) {
             setState(() {
               last = true ;
             });
            } else {
              setState(() {
                last = false ;
              });
            }
          },
          itemBuilder: (context, index) {
            return Column(
              children: [
                pages[index],
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SmoothPageIndicator(
                          controller: controller, // PageController
                          count: 3,
                          effect: ExpandingDotsEffect(
                              spacing: 5.0,
                              dotWidth: 15.0,
                              dotHeight: 12.0,
                              dotColor: Colors.grey,
                              activeDotColor: basicColor),
                        ),
                        FloatingActionButton(
                          onPressed: () {
                            if (last == true ) {
                              SharedPrefrence.saveData(key:'OnBoarding',value: true).then((value) {
                                if (value == true) {
                                  NavAndRemove(screen: LoginScreen() , ctx: context);
                                }
                              });
                            }
                            else {
                              controller.nextPage(
                                  duration: Duration(
                                    milliseconds: 550,
                                  ),
                                  curve: Curves.fastLinearToSlowEaseIn);
                            }
                          },
                          child: last == true ? CustomText(
                            txt: 'Done',
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            textAlign: TextAlign.center,
                            fontfamily: 'assets/fonts/Cairo-VariableFont_wght.ttf',
                            fontSize: 14,
                          ): Icon(Icons.arrow_forward_ios),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
          controller: controller,
          physics: BouncingScrollPhysics(),
          itemCount: pages.length,
        ),
      ),
    );
  }
}

Widget Colu(String image , String txt1) {
  return Padding(
    padding: const EdgeInsets.only(left: 20.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          image,
        ),
        CustomText(
          txt: 'On Boarding Screens',
          color: Colors.black,
          fontfamily: 'assets/fonts/Cairo-VariableFont_wght.ttf',
          fontWeight: FontWeight.bold,
          textAlign: TextAlign.left,
          fontSize: 20,
        ),
        SizedBox(
          height: 30,
        ),
        CustomText(
          txt: txt1,
          color: Colors.black,
          fontfamily: 'assets/fonts/Cairo-VariableFont_wght.ttf',
          fontWeight: FontWeight.w500,
          textAlign: TextAlign.left,
          fontSize: 15,
        ),

      ],
    ),
  );
}
