import 'package:flutter/material.dart';
import 'package:medicaly/sql.dart';

import 'homePage.dart';

Widget textfield1(
    TextEditingController c, String title, String hint, bool isNumber) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 15),
    child: TextField(
      controller: c,
      keyboardType: isNumber ? TextInputType.number : null,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        label: Text(title,
            style: const TextStyle(color: Colors.black, fontSize: 24)),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 10),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 15),
    ),
  );
}
