import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

Widget richTextWidget({
  String? text1,
  String? text2,
  String? text3,
  TextStyle? textStyle1,
  TextStyle? textStyle2,
  TextStyle? textStyle3,
  GestureRecognizer? recognizer2,
  GestureRecognizer? recognizer3,
}) {
  return RichText(
    text: TextSpan(
      text: text1,
      style: textStyle1,
      children: <TextSpan>[
        TextSpan(
          text: text2,
          style: textStyle2,
          recognizer: recognizer2,
        ),
        TextSpan(
          text: text3,
          style: textStyle3,
          recognizer: recognizer3,
        ),
      ],
    ),
  );
}
