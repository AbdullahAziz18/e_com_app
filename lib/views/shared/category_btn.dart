import 'package:e_com_app/views/shared/appstyle.dart';
import 'package:flutter/material.dart';

class CategoryBtn extends StatelessWidget {
  const CategoryBtn(
      {super.key, this.onPress, required this.buttonClr, required this.label});
  final void Function()? onPress;
  final Color buttonClr;
  final String label;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPress,
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width * 0.244,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: buttonClr,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Center(
          child: Text(
            label,
            style: appStyle(15, buttonClr, FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
