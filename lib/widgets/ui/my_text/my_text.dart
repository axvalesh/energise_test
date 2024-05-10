import 'package:flutter/material.dart';


enum TextVariants {
  regular,
  bold,
}
class MyText extends StatelessWidget {
  final String text;
  final TextVariants textVariant;
  final double? lineHeight;
  final double? fontSize;
  final Color? textColor;
  final bool? underline;
  final TextAlign? textAlign;
  
  const MyText({super.key, this.lineHeight, this.textAlign, required this.textVariant, this.textColor, required this.text, this.fontSize, this.underline=false});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle;

    switch (textVariant) {
      case TextVariants.regular:
        textStyle = Theme.of(context).textTheme.bodyLarge!;
        break;
      case TextVariants.bold:
        textStyle = Theme.of(context).textTheme.titleMedium!;
        break;
      default:
        textStyle = Theme.of(context).textTheme.bodyLarge!; // Default to w400
    }

    if(lineHeight != null) {
      textStyle = textStyle.copyWith(height: lineHeight);
    } else {
      textStyle = textStyle.copyWith(height: 1);
    }

    if (textColor != null) {
      textStyle = textStyle.copyWith(color: textColor,);
    }
    if(underline!) {
      textStyle = textStyle.copyWith(decoration: TextDecoration.underline,decorationColor: Colors.white,decorationThickness: 1.5,);
    }
    if(fontSize != null) {
      textStyle = textStyle.copyWith(fontSize: fontSize);
    }

    return Text(
      text, // Replace with your text
      style: textStyle,
      textAlign: textAlign,
    );
  }
}

class MyTextMultiItems extends StatelessWidget {
  final List<MyText> texts;

  const MyTextMultiItems({super.key, required this.texts});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: _buildTextSpans(),
      ),
    );
  }

  List<TextSpan> _buildTextSpans() {
    List<TextSpan> textSpans = [];

    for (int i = 0; i < texts.length; i++) {
      MyText myText = texts[i];

      TextStyle textStyle;

      switch (myText.textVariant) {
        case TextVariants.regular:
          textStyle = const TextStyle(fontWeight: FontWeight.w400);
          break;
        case TextVariants.bold:
          textStyle = const TextStyle(fontWeight: FontWeight.w700);
          break;
        default:
          textStyle = const TextStyle(fontWeight: FontWeight.w400);
      }

      if (myText.textColor != null) {
        textStyle = textStyle.copyWith(color: myText.textColor);
      }
      if (myText.fontSize != null) {
        textStyle = textStyle.copyWith(fontSize: myText.fontSize);
      }

      if (myText.underline!) {
        textStyle = textStyle.copyWith(decoration: TextDecoration.underline);
      }

      textSpans.add(TextSpan(text: myText.text, style: textStyle));
    }

    return textSpans;
  }
}
