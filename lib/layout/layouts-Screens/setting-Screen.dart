import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shopp_app/layout/layouts-Screens/homeCubit.dart';
import 'package:shopp_app/layout/layouts-Screens/homeStates.dart';

import '../../style/Constant.dart';
import '../../style/custom_button.dart';
import '../../style/custom_text_field.dart';
class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    TextEditingController name = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController phone = TextEditingController();
    return BlocConsumer<HomeCubit,States>(
      listener: (context, state) => {},
      builder: (context, state) {
        HomeCubit? model = HomeCubit.get(context);
        name.text = model.login!.data!.name.toString();
        print ('here${ name.text}');
        email.text = model.login!.data!.email.toString();
        phone.text = model.login!.data!.phone.toString();
        return Scaffold(
        body: ConditionalBuilder(
          condition: model.login != null,
          builder:(context) => Container(
            height: 250.h,
            margin: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextFormField(
                    controller: name,
                    validator: (String n) {
                      if (n.isEmpty) {
                       return 'The Name is Empty' ;
                      }
                    },
                    colorBorder: Colors.grey,
                    prefexIcon: Icons.person,
                    label: 'User Name',
                    contentPadding: 5.0,

                  ) ,
                  Spacer(),
                  CustomTextFormField(
                    controller: email,
                    validator: (String n) {
                      if (n.isEmpty) {
                        return 'The Email is Empty' ;
                      }
                    },
                    colorBorder: Colors.grey,
                    prefexIcon: Icons.email,
                    label: 'Email',
                    contentPadding: 5.0,

                  ) ,
                  Spacer(),
                  CustomTextFormField(
                    controller: phone,
                    validator: (String n) {
                      if (n.isEmpty) {
                        return 'The Phone Number is Empty' ;
                      }
                    },
                    colorBorder: Colors.grey,
                    prefexIcon: Icons.phone,
                    label: 'Phone Number',
                    contentPadding: 5.0,

                  ) ,
                  Spacer(),
                  CustomButton(
                    width: double.infinity,
                    high: 35.h,
                    txt: 'LOGOUT',
                    outLineBorder: false,
                    borderRadius: 3.r,
                    colorButton: Colors.black38,
                    onPressed: () {
                      removeAllLogout (context) ;
                    },
                  ),
                ],
              )),
          fallback: (context) => Center(
            child: LoadingAnimationWidget.threeRotatingDots(
              color: Colors.black38,
              size: 35.sp,
            ),
          ),
        ),
      );
      },
    );
  }
}
