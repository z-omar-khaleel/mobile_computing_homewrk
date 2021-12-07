import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

Widget defaultFormField(
        {required TextEditingController? controller,
        required TextInputType? type,
        void Function(String? s)? onSubmit,
        void Function(String? s)? onChange,
        void Function()? onTap,
        bool isPassword = false,
        String? Function(String? s)? validate,
        String? label,
        Widget? prefix,
        Icon? suffix,
        void Function()? suffixPressed,
        bool isClickable = true,
        double focusBorderRadius = 12,
        double labelFontSize = 14,
        Color focusColor = Colors.grey,
        Key? key,
        Color? fillColor,
        Color? labelColor = const Color(0xff707070),
        void Function(String?)? onSaved,
        Color borderColor = Colors.grey,
        double borderRadius = 12,
        Color? writeTxtStyle,
        FocusNode? focusNode,
        void Function()? onEditingComplete,
        TextInputAction? textInputAction,
        void Function()? prefixPressed,
        String? hintText}) =>
    TextFormField(
      textInputAction: textInputAction,
      focusNode: focusNode,
      style: TextStyle(color: writeTxtStyle, fontSize: 14),
      key: key,
      onEditingComplete: onEditingComplete,
      onSaved: onSaved,
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        filled: fillColor == null ? false : true,
        fillColor: fillColor,
        helperText: hintText,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
            borderRadius: BorderRadius.circular(borderRadius)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: focusColor),
            borderRadius: BorderRadius.circular(focusBorderRadius)),
        labelText: label,
        labelStyle: TextStyle(fontSize: labelFontSize, color: labelColor),
        prefixIcon: prefix != null
            ? InkWell(onTap: prefixPressed, child: prefix)
            : null,
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: suffix,
              )
            : null,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(focusBorderRadius))),
      ),
    );

class Utility {
  //

  //when fetch from sqlite
  static Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

//base64String(file.readAsBytesSync()) when store in sqlite
  static String base64String(Uint8List data) {
    return base64Encode(data);
  }
}
