import 'package:flutter/material.dart';

Widget appBar(BuildContext context) {
  return RichText(
    text: TextSpan(style: TextStyle(fontSize: 22), children: <TextSpan>[
      TextSpan(
          text: 'Quiz',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black54)),
      TextSpan(
          text: 'Maker',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blue)),
    ]),
  );
}

Widget blueButton({BuildContext context, String label, buttonWidth}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 16),
    width: buttonWidth != null ? buttonWidth
        : MediaQuery.of(context).size.width - 48,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
      color: Colors.blue,
    ),
    child: Text(
      label,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 16, color: Colors.white),
    ),
  );
}
