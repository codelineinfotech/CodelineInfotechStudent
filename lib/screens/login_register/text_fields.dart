import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

Widget signTextField(
    {title,
    icon,
    placeholder,
    bool obsecureText,
    FocusNode focusNode,
    onEditComplete,
    String rePassword,
    bool passwordLength,
    TextEditingController controller,
    Function passwordVisibleClick,
    bool emailValidation,
    String regularExpressions,
    int inputTextLength}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
          fontSize: 14,
          color: Color(0xff17a2b8),
        ),
      ),
      TextFormField(
        focusNode: focusNode,
        textInputAction: TextInputAction.next,
        onEditingComplete: onEditComplete,
        obscureText: obsecureText ?? false,
        controller: controller,
        // autovalidateMode: AutovalidateMode.always,
        inputFormatters: [
          LengthLimitingTextInputFormatter(inputTextLength),
          FilteringTextInputFormatter.allow(RegExp(regularExpressions))
        ],
        validator: (value) => value.isEmpty
            ? '* Require'
            : emailValidation == true
                ? GetUtils.isEmail(value)
                    ? null
                    : 'Please Enter Valid Email!'
                : rePassword != null
                    ? rePassword == value
                        ? null
                        : 'Password and Confirm Password Not Match!'
                    : passwordLength == true
                        ? value.length < 6
                            ? 'Password Must less then 6 Character!'
                            : null
                        : null,
        style: TextStyle(
          fontSize: 17,
          color: const Color(0xff3a3f44),
        ),
        decoration: InputDecoration(
          suffixIcon: obsecureText == null
              ? SizedBox()
              : GestureDetector(
                  onTap: passwordVisibleClick,
                  child: Icon(
                    !obsecureText ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
          hintText: placeholder ?? "Enter $title",
          hintStyle: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 17,
            color: const Color(0xff3a3f44).withOpacity(0.5),
          ),
          prefixIcon: Image.asset(
            "assets/images/$icon.png",
            height: 5,
            width: 5,
          ),
        ),
      )
    ],
  );
}

Widget addTextField(
    {title,
    icon,
    bool obsecureText,
    String placeholder,
    onEditComplete,
    FocusNode focusNode,
    TextEditingController editingController,
    Function onChange,
    suffixIcon}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
          fontSize: 14,
          color: Color(0xff1582f4),
        ),
      ),
      TextField(
        textInputAction: TextInputAction.next,
        onEditingComplete: onEditComplete,
        controller: editingController,
        obscureText: obsecureText ?? false,
        autofocus: false,
        onChanged: onChange,
        focusNode: focusNode,
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 17,
          color: const Color(0xff3a3f44),
        ),
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          hintText: placeholder ?? "Enter ${title}",
          hintStyle: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 17,
            color: const Color(0xff3a3f44).withOpacity(0.5),
          ),
        ),
      )
    ],
  );
}
