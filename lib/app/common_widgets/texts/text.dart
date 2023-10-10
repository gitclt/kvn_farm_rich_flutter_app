import 'package:flutter/material.dart';
import 'package:kvn_farm_rich/constraints/app_colors.dart';

Text greyText(String label, double fontSize,
    {TextAlign? textAlign,
    TextOverflow? textOverflow,
    FontWeight? fontWeight = FontWeight.w400}) {
  return Text(
    label,
    textAlign: textAlign,
    style: TextStyle(
        fontFamily: 'Manrope',
        overflow: textOverflow,
        color: const Color(0xFF7B7B7B),
        fontSize: fontSize,
        fontWeight: fontWeight),
  );
}

Text blackText(
  String label,
  double fontSize, {
  TextAlign? textAlign,
  FontWeight? fontWeight = FontWeight.w400,
  TextOverflow? textOverflow,
}) {
  return Text(
    label,
    textAlign: textAlign,
    style: TextStyle(
        fontFamily: 'Manrope',
        overflow: textOverflow,
        color: Colors.black,
        fontSize: fontSize,
        fontWeight: fontWeight),
  );
}

Text redText(
  String label,
  double fontSize, {
  TextAlign? textAlign,
  FontWeight? fontWeight = FontWeight.w400,
  TextOverflow? textOverflow,
}) {
  return Text(
    label,
    textAlign: textAlign,
    style: TextStyle(
        fontFamily: 'Manrope',
        overflow: textOverflow,
        color: redColor,
        fontSize: fontSize,
        fontWeight: fontWeight),
  );
}
