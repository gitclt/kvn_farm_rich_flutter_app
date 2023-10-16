import 'package:flutter/material.dart';
import 'package:kvn_farm_rich/constraints/app_colors.dart';

class CommonButtonWidget extends StatelessWidget {
  final String label;
  final Color? color;
  final double? fontSize;
  final double? borderRadius;
  final VoidCallback onClick;
  final bool? isLoading;
  final double? height;

  const CommonButtonWidget(
      {super.key,
      required this.label,
      required this.onClick,
      this.fontSize,
      this.isLoading,
      this.borderRadius = 10,
      this.color,
      this.height});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClick();
      },
      child: Container(
          width: double.maxFinite,
          height: height ?? MediaQuery.of(context).size.height * .07,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius!),
              // color: color ?? AppColors().primaryColor
              gradient: primaryColor),
          child: isLoading == true
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : Center(
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fontSize,
                      fontFamily: "Manrope",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )),
    );
  }
}
