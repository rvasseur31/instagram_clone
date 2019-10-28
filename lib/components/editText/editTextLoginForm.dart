import 'package:flutter/material.dart';
import 'package:instagram_clone_androidx/utils/colors.dart';


Container editText(width, content, isPassword) {
  return (Container(
    margin: EdgeInsets.only(top: 20.0),
    width: width,
    height: 50.0,
    child: new TextFormField(
      decoration: new InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.grey700, width: 1.0),
          borderRadius: BorderRadius.circular(7.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.0),
          borderSide: const BorderSide(color: AppColors.grey700, width: 1.0),
        ),
        filled: true,
        hintText: content,
        fillColor: Colors.grey[200],
      ),
      autofocus: false,
      style: new TextStyle(
        fontFamily: "Poppins",
      ),
      cursorColor: AppColors.grey700,
      obscureText: (isPassword)?true:false,
      // validator: (_) {
      //   return !state.isPasswordValid ? 'Mot de passe Invalide' : null;
      // },
    ),
  ));
}
