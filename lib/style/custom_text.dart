import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String? txt;
  final double? fontSize;
  final int? maxLine;
  final double? height;
  final double? wordSpacing;
  final Color? color;
  final FontWeight? fontWeight;
  final String fontfamily ;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final TextDecoration? decoration;


  CustomText({
    this.txt = "",
    this.height = 1,
    this.fontfamily = '' ,
    this.fontSize = 16,
    this.maxLine = 20 ,
    this.color = Colors.black,
    this.fontWeight = FontWeight.w400,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.ellipsis,
    this.wordSpacing = 1,
    this.decoration = TextDecoration.none,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      txt!,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        decoration: decoration,
        fontSize: fontSize,
        color: color,
        fontFamily:fontfamily ,
        fontWeight: fontWeight,
        height: height,
        wordSpacing: wordSpacing,
      ),
      textAlign: textAlign,
    );
  }
}
