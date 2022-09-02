import 'package:flutter/material.dart';
import 'package:todo/ui/theme.dart';

class MyButton extends StatelessWidget {
  const MyButton({Key? key, required this.label, required this.onTab})
      : super(key: key);

  final String label;
  final Function() onTab;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        alignment: Alignment.center,
        width: 100,
        height: 45,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: primaryClr),
        // ignore: prefer_const_constructors
        child: Text(
          label,
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
