import 'package:flutter/material.dart';
import 'package:profile/models/profile_model.dart';

class NewProfileInfo extends StatefulWidget {
  const NewProfileInfo({super.key, required this.onAddNewPfofileInfo});

  final void Function(ProfileModel value) onAddNewPfofileInfo;

  @override
  State<NewProfileInfo> createState() {
    return _NewProfileInfoState();
  }
}

class _NewProfileInfoState extends State<NewProfileInfo> {
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _positionController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _descriptionController = TextEditingController();

  void _submitNewProfileInfo() {
    widget.onAddNewPfofileInfo(ProfileModel(
      name: _nameController.text,
      surname: _surnameController.text,
      position: _positionController.text,
      phone: _phoneController.text,
      email: _emailController.text,
      address: _addressController.text,
      description: _descriptionController.text,
    ));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _positionController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 166, 197, 227),
            Color.fromARGB(255, 233, 242, 243),
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Name',
              ),
              maxLength: 50,
              controller: _nameController,
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Surname',
              ),
              maxLength: 50,
              controller: _surnameController,
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Position',
              ),
              maxLength: 100,
              controller: _positionController,
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Phone number',
              ),
              maxLength: 15,
              controller: _phoneController,
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
              maxLength: 50,
              controller: _emailController,
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Address',
              ),
              maxLength: 200,
              controller: _addressController,
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: 'About you',
              ),
              maxLength: 200,
              controller: _descriptionController,
            ),
            TextButton(
              onPressed: () {
                _submitNewProfileInfo();
                //print(_nameController.text);
              },
              child: const Text('save'),
            )
          ],
        ),
      ),
    );
  }
}








/* Form(
      child: Column(
        children: [
          TextFormField(
            maxLength: 50,
            decoration: const InputDecoration(label: Text('name')),
            validator: (value) {
              return 'invalid name';
            },
          ),
        ],
      ),
    ); */