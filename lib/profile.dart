import 'package:flutter/material.dart';
import 'package:profile/new_profile_info.dart';
import 'package:profile/profile_item.dart';
import 'package:profile/models/profile_model.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<Profile> {
  final ProfileModel _currentUser = ProfileModel(
    name: '',
    surname: '',
    phone: '',
    email: '',
  );

  void _saveNewProfileInfo(ProfileModel value) {
    setState(() {
      _currentUser.name = value.name;
      _currentUser.surname = value.surname;
      _currentUser.position = value.position;
      _currentUser.phone = value.phone;
      _currentUser.email = value.email;
      _currentUser.address = value.address;
      _currentUser.description = value.description;
    });
  }

  void _changeUserData() {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (ctx) =>
          NewProfileInfo(onAddNewPfofileInfo: _saveNewProfileInfo),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TextButton(
          onPressed: _changeUserData,
          child: _currentUser.name == '' ? const ProfileItem('Name') : ProfileItem(_currentUser.name),
        ),
        TextButton(
          onPressed: _changeUserData,
          child: _currentUser.surname == '' ? const ProfileItem('Surname') : ProfileItem(_currentUser.surname),
        ),
        TextButton(
          onPressed: _changeUserData,
          child: _currentUser.position == '' ? const ProfileItem('Position') : ProfileItem(_currentUser.position),
        ),
        TextButton(
          onPressed: _changeUserData,
          child: _currentUser.phone == '' ? const ProfileItem('Phone number') : ProfileItem(_currentUser.phone),
        ),
        TextButton(
          onPressed: _changeUserData,
          child: _currentUser.email == '' ? const ProfileItem('Email') : ProfileItem(_currentUser.email),
        ),
        TextButton(
          onPressed: _changeUserData,
          child: _currentUser.address == '' ? const ProfileItem('Address') : ProfileItem(_currentUser.address),
        ),
        TextButton(
          onPressed: _changeUserData,
          child: _currentUser.description == '' ? const ProfileItem('About you') : ProfileItem(_currentUser.description),
        ),
      ],
    );
  }
}
