import 'package:flutter/material.dart';

class MyDialog extends StatelessWidget {
  final Widget body;

  const MyDialog({super.key, required this.body});
  
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white.withOpacity(0.9),
      clipBehavior: Clip.hardEdge,
      insetPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
      child: Container(
        height: MediaQuery.of(context).size.height - 20,
        // Replace this with your custom content
        child: Scrollbar(
          thickness: 5,
          thumbVisibility: true,
          child: SingleChildScrollView(child: body,))
      ),
    );
  }
}
