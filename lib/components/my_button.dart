import 'package:flutter/material.dart';

class Mybutton extends StatelessWidget {
  const Mybutton({super.key, required this.onTap, required this.typeOfButton});
  final Function()? onTap;
  final String typeOfButton;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(25),
          margin: const EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(8)),
          child: Center(
              child: Text(
            typeOfButton,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          )),
        ));
  }
}
