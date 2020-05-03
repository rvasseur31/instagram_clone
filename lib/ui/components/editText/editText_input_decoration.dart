import 'package:flutter/material.dart';

Container editTextContainer(double width, String content, TextInputType textInputType, Color outlineColor) {
  return Container(
    margin: EdgeInsets.only(top: 20.0),
    width: width / 1.15,
    height: 50.0,
    child: new TextFormField(
        decoration: editTextInputDecoration(content, outlineColor),
        autofocus: false,
        style: new TextStyle(
          fontFamily: "Poppins",
        ),
        cursorColor: outlineColor,
        keyboardType: textInputType
        // validator: (_) {
        //   return !state.isEmailValid ? 'Invalid Password' : null;
        // },
        ),
  );
}

InputDecoration editTextInputDecoration(String content, Color outlineColor) {
  return InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: outlineColor, width: 1.0),
      borderRadius: BorderRadius.circular(7.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(7.0),
      borderSide: BorderSide(color: outlineColor, width: 1.0),
    ),
    filled: true,
    hintText: content,
    fillColor: Colors.grey[200],
  );
}
