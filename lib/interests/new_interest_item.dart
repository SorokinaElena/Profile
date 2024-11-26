import 'package:flutter/material.dart';

class NewInterestItem extends StatelessWidget {
  const NewInterestItem({
    super.key,
    required this.title,
    required this.controller,
    required this.onAddInterest,
    required this.onClearInterests,
  });

  final String title;
  final TextEditingController controller;
  final void Function(String? interest) onAddInterest;
  final void Function() onClearInterests;


  @override
  Widget build(BuildContext context) {
    return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  color: Colors.black,
                ),
                'Add your $title item:'),
            const SizedBox(
              height: 10,
            ),
            TextField(
              autofocus: true,
              controller: controller,
              maxLength: 30,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: onClearInterests,
                  child: Text('Clear $title'),
                ),
                const SizedBox(
                  width: 30,
                ),
                ElevatedButton(
                  onPressed: () => onAddInterest(controller.text),
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        );
  }
}
