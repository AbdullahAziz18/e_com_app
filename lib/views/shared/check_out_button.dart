import 'package:e_com_app/views/shared/appstyle.dart';
import 'package:flutter/material.dart';

class CheckOutButton extends StatelessWidget {
  const CheckOutButton({
    super.key,
    this.onTap,
    required this.label,
  });
  final void Function()? onTap;
  final String label;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(18)),
          child: Center(
            child: Text(
              label,
              style: appStyle(18, Colors.white, FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
