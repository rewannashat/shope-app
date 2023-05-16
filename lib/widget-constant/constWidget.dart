import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future NavAndRemove ({screen , ctx}) {
  return  Navigator.pushAndRemoveUntil(ctx, MaterialPageRoute(builder:  (ctx) => screen,), (route) => false);
}
 Future NormalNav ({screen, ctx}) {
  return  Navigator.push(ctx, MaterialPageRoute(builder:(ctx) => screen(),));
 }
enum StatusCase {SUCCES , ERROR , EARNING}

 void toast ({
  required String msg ,
   required StatusCase state ,
}) {
   Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: ChangeColor(state),
      textColor: Colors.white,
      fontSize: 16.0) ;
 }

 Color ChangeColor (StatusCase st) {
  Color? c ;
  switch (st) {
    case StatusCase.SUCCES :
      c =  Colors.green ;
    break ;
    case StatusCase.ERROR :
      c =  Colors.red ;
      break ;
    case StatusCase.EARNING :
      c =  Colors.amber ;
      break ;
  }
  return c ;
 }

Widget divider () {
  return  Divider(color: Colors.grey,height: 5,);
}