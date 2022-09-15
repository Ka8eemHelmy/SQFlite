import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget CustomTextInput(String hint, TextEditingController controller,
    TextInputType type, bool isObscureText, String? Function(String?)? validate,
    {TextInputAction? textInputAction = TextInputAction.next}) {
  return Card(
    color: Colors.green[100],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: TextFormField(
      keyboardType: type,
      controller: controller,
      obscureText: isObscureText,
      autofocus: false,
      cursorColor: Colors.green,
      validator: validate,
      textInputAction: textInputAction,
      style: GoogleFonts.roboto(fontSize: 20, color: Colors.green),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hint,
        hintStyle: TextStyle(color: Colors.green),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      ),
    ),
  );
}
