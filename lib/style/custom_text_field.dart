import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintTxt;
  final String? label;
  final String? helperText;
  final IconData? suffexIcon;
  final IconData? prefexIcon;
  final Function? onSaved;
  final Function? validator;
  final Function? onChange;
  final Function? onPressedSuffexIcon;
  final Function? onPressedPrefexIcon;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final double? fontSize;
  final double? contentPadding;
  final Color? color;
  final Color? colorBorder ;
  final FontWeight? fontWeight;
  final bool? obscureText;
  final int? minLines;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final OutlineInputBorder? out ;



  CustomTextFormField({
    this.hintTxt,
    this.out,
    this.onSaved,
    this.validator,
    this.suffexIcon,
    this.onPressedSuffexIcon,
    this.onPressedPrefexIcon,
    this.keyboardType,
    this.colorBorder,
    this.label,
    this.controller,
    this.onChange,
    this.fontSize = 16,
    this.color = Colors.black,
    this.fontWeight = FontWeight.w600,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines = 1,
    this.helperText = '',
    this.prefexIcon,
    this.contentPadding = 12,
    this.textAlign = TextAlign.right,
    this.textDirection = TextDirection.rtl,
  });

  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    return TextFormField(
      cursorColor:Colors.black ,
      onSaved: (val) => onSaved!(val),
      validator: (val) => validator!(val),
      controller: controller,
      onChanged: (val) => onChange!(),
      minLines: minLines,
      maxLines: maxLines,
      decoration: InputDecoration(
        focusColor: Colors.white,
        prefixIcon: IconButton(
          icon: Icon(prefexIcon),
          onPressed:() => onPressedPrefexIcon!(),
          color: Colors.grey,
        ),
        suffixIcon: IconButton(
          onPressed: () => onPressedSuffexIcon!(),
          icon: Icon(suffexIcon),
          color: Colors.grey,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:  BorderSide(color: colorBorder!, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        fillColor: Colors.grey,
        hintText:hintTxt ,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: media.size.height * 0.02,
          fontFamily: "Cairo",
          fontWeight: FontWeight.w400,
        ),
        labelText: label,
        //  errorText: error,
        labelStyle: TextStyle(
          color: Colors.grey,
          fontSize: media.size.height * 0.02,
          fontWeight: FontWeight.w400,
        ),
      ),
      keyboardType: keyboardType,
      obscureText: obscureText!,

    );
  }
}
