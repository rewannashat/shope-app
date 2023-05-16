import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_text.dart';

class customTextClick extends StatelessWidget {
  final String? txt;

  final Function? function;

  final Color? color;

  final FontWeight? fontWeight;

  final String? fontfamily;

  final TextAlign? textAlign;

  final double? fontSize;

  const customTextClick(
      {
      this.txt,
      this.function,
      this.color,
      this.fontWeight,
      this.fontfamily,
      this.textAlign,
      this.fontSize});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed:function!(),
      child: CustomText(
        txt: txt,
        color: color,
        fontWeight: fontWeight,
        textAlign: textAlign,
        fontfamily: fontfamily!,
        fontSize: fontSize,
      ),
    );
  }
}
