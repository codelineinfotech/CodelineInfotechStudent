import 'package:flutter/material.dart';

BoxDecoration progressDecoration = BoxDecoration(
  borderRadius: BorderRadius.vertical(
    top: Radius.circular(30),
  ),
  color: Color(0xff31AFC3),
  boxShadow: [
    BoxShadow(
        offset: Offset(0, -3),
        color: Colors.black.withOpacity(0.16),
        blurRadius: 20)
  ],
);

BoxDecoration whiteDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.vertical(
    top: Radius.circular(30),
  ),
);
