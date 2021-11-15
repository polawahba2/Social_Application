import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  Widget? child;
  Color? color;
  TextFieldContainer({
    this.child,
    this.color = const Color.fromRGBO(188, 188, 188, 0.5),
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}
