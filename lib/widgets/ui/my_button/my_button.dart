import 'package:energise/constants/app_colors.dart';
import 'package:energise/widgets/ui/my_text/my_text.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Function onClick;
  final double? width;
  final Color? color;
  const MyButton({super.key, required this.text, required this.onClick, this.color, this.width});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () { onClick(); },
      child: Container(
        width: width,
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: color ?? AppColors.green,
        ),
        alignment: Alignment.center,
        child: MyText(
          text: text,
          textAlign: TextAlign.center,
          textColor: Colors.white,
          fontSize: 24,
          textVariant: TextVariants.bold,
        ),
      ),
    );
  }
}