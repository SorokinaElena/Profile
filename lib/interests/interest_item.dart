import 'package:flutter/material.dart';

class InterestItem extends StatelessWidget {
  const InterestItem(this.value, {super.key});
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(7),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(97, 0, 0, 0),
          width: 1.41,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        style: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 19,
          color: Colors.black,
        ),
        value),
    );
  }
}