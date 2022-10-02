import 'package:flutter/material.dart';

class LoginDataField extends StatelessWidget {
  final String text;
  final String hinttext;
  final TextEditingController controller;
  final bool obscureText;
  final dynamic validator;

  LoginDataField({
    required this.controller,
    required this.text,
    required this.hinttext,
    required this.obscureText,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text, style: const TextStyle(color: Colors.black54)),
        const SizedBox(
          height: 5.0,
        ),
        Container(
          height: 40,
          padding: const EdgeInsets.only(left: 20.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 4,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Baseline(
            baseline: 25,
            baselineType: TextBaseline.alphabetic,
            child: TextFormField(
              controller: controller,
              textInputAction: TextInputAction.done,
              validator: validator,
              onChanged: (text) {
                print('text field: $text');
              },
              obscureText: obscureText,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hinttext,
                helperText: ' ',
              ),
              textAlignVertical: TextAlignVertical.bottom,
            ),
          ),
        ),
      ],
    );
  }
}
