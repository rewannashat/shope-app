import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopp_app/layout/layouts-Screens/home.dart';
import 'package:shopp_app/layout/module/authorize/Login/Login/LoginCubit.dart';
import 'package:shopp_app/layout/module/authorize/Login/Login/LoginStates.dart';

import '../../../../../shared/local/sharedPref.dart';
import '../../../../../style/Constant.dart';
import '../../../../../style/custom-text-click.dart';
import '../../../../../style/custom_button.dart';
import '../../../../../style/custom_text.dart';
import '../../../../../style/custom_text_field.dart';
import '../../../../../widget-constant/constWidget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> form = GlobalKey<FormState>();
    TextEditingController email = TextEditingController();
    TextEditingController pass = TextEditingController();
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) => {
          if (state is GetLoginDataSucess)
            {
              if (state.login.status)
                {
                  toast(msg: state.login.message.toString(), state: StatusCase.SUCCES),
                  SharedPrefrence.saveData(
                          key: 'Authorization', value: state.login.data!.token)
                      .then((value) {
                    if (value == true) {
                      token = state.login.data!.token ;
                      NavAndRemove(screen: HomeLayout(), ctx: context);
                    }
                  }),
                }
              else
                {toast(msg: state.login.message.toString(), state: StatusCase.ERROR)}
            }
        },
        builder: (context, state) {
          LoginCubit cubit = LoginCubit.get(context);
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: form,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      txt: 'LOGIN',
                      color: Theme.of(context).textTheme.bodyText1?.color,
                      fontWeight: FontWeight.w900,
                      textAlign: TextAlign.center,
                      fontfamily: 'assets/fonts/Cairo-VariableFont_wght.ttf',
                      fontSize: 14,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      txt: 'Login now to brows or hot offers',
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.center,
                      fontfamily: 'assets/fonts/Cairo-VariableFont_wght.ttf',
                      fontSize: 14,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    CustomTextFormField(
                      controller: email,
                      label: 'email Address',
                      hintTxt: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.left,
                      prefexIcon: Icons.email,
                      colorBorder: insideLayout,
                      validator: (String v) {
                        if (v.isEmpty) {
                          return 'Email be required';
                        }
                      },
                      fontSize: 12,
                      fontWeight: FontWeight.w200,
                      color: Theme.of(context).textTheme.bodyText1?.color,
                      maxLines: 1,
                      onChange: () {},
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      controller: pass,
                      label: 'Password',
                      hintTxt: 'Password',
                      keyboardType: TextInputType.visiblePassword,
                      textAlign: TextAlign.left,
                      prefexIcon: Icons.lock_open,
                      suffexIcon: cubit.icons,
                      colorBorder: insideLayout,
                      onPressedSuffexIcon: () {
                        cubit.changePass();
                        cubit.loginApp(email.text, pass.text);
                      },
                      obscureText: cubit.isShow,
                      onChange: () {},
                      validator: (String v) {
                        if (v.isEmpty) {
                          return 'Password be required';
                        }
                      },
                      fontSize: 12,
                      fontWeight: FontWeight.w200,
                      color: Theme.of(context).textTheme.bodyText1?.color,
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ConditionalBuilder(
                      builder: (context) => CustomButton(
                        txt: 'LOGIN',
                        width: double.infinity,
                        high: 40,
                        fontWeight: FontWeight.w600,
                        onPressed: () {
                          if (form.currentState!.validate()) {
                            cubit.loginApp(email.text, pass.text);
                          }
                        },
                        colorButton: insideLayout,
                        fontSize: 12.0,
                        alignment: Alignment.center,
                        colorTxt: Colors.white,
                        borderRadius: 10,
                        outLineBorder: false,
                      ),
                      fallback: (context) =>
                          Center(child: CircularProgressIndicator()),
                      condition: state is! LoginLoadingState,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          txt: 'Don\'t have an account ?',
                          color: Theme.of(context).textTheme.bodyText1?.color,
                          fontWeight: FontWeight.w400,
                          textAlign: TextAlign.center,
                          fontfamily:
                              'assets/fonts/Cairo-VariableFont_wght.ttf',
                          fontSize: 14,
                        ),
                        customTextClick(
                          fontSize: 14.0,
                          txt: 'Register',
                          color: insideLayout,
                          fontWeight: FontWeight.w600,
                          textAlign: TextAlign.center,
                          fontfamily:
                              'assets/fonts/Cairo-VariableFont_wght.ttf',
                          function: () {},
                        )
                      ],
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
}
