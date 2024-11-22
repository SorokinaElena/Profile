import 'package:flutter/material.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem(this.value, {super.key});
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 13, 20, 13),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(97, 0, 0, 0),
          width: 1.41,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(11),
      ),
      child: Text(
        style: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 18,
          color: Colors.black,
        ),
        value),
    );
  }
}