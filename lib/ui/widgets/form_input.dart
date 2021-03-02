import 'package:flutter/material.dart';

Widget formField<T>(
    {T model,
    int errorIndex,
    String title,
    TextEditingController controller,
    String initialValue,
    bool obscureText,
    dynamic modelError}) {
  return Container(
    margin: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent),
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextFormField(
            obscureText: obscureText,
            controller: controller,
            decoration: InputDecoration.collapsed(
              hintText: title,
              border: InputBorder.none,
            ),
            //initialValue: initialValue,
          ),
        ),
        modelError[errorIndex] != null
            ? Center(
                child: Text(
                  modelError[errorIndex].toString(),
                  style: TextStyle(color: Colors.red),
                ),
              )
            : Container(),
      ],
    ),
  );
}
