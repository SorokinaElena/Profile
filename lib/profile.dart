import 'package:flutter/material.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:profile/models/profile_model.dart';
import 'package:profile/interests/interest_item.dart';
import 'package:profile/interests/new_interest_item.dart';
import 'package:profile/site_link_item.dart';
import 'package:image_picker/image_picker.dart';


class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  final ProfileModel _currentUser = ProfileModel(
    name: '',
    surname: '',
    phone: '',
    email: '',
    profileType: 'Private',
    interests: [],
    potentialInterests: [],
    siteNames: [],
    siteLinks: [],
  );
  String? _savedData;
  bool isSucsessSave = false;
  int maxLinksLength = 0;
  String _savedInterests = '';
  String _savedPotentialInterests = '';
  String _savedSiteNames = '';
  String _savedSiteLinks = '';
  File? _image;
  String _imagePath = '';
  final ImagePicker _picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _interestController = TextEditingController();

  final FocusNode _focusNodeName = FocusNode();
  final FocusNode _focusNodeSurname = FocusNode();
  final FocusNode _focusNodePosition = FocusNode();
  final FocusNode _focusNodePhone = FocusNode();
  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodeAddress = FocusNode();
  final FocusNode _focusNodeDescription = FocusNode();
  final FocusNode _focusNodeSiteName = FocusNode();
  final FocusNode _focusNodeSiteLink = FocusNode();

  final RegExp strictRegex = RegExp(r'^[A-Za-zА-Яа-яЁё\s]+$');
  final RegExp regex = RegExp(r'^[A-Za-zА-Яа-яЁё0-9\s]+$');
  final RegExp phoneRegex = RegExp(r'^\+\d+$');
  final RegExp emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  final RegExp textRegex = RegExp(r'^[a-zA-ZА-Яа-яЁё0-9 .,\\-]+$');

  void _selectProfileType(String? value) {
    setState(() {
      _currentUser.profileType = value!;
    });
  }

  void _openAddInterestOverLay(addInterest, clearInterests, String title) {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(30),
        constraints: const BoxConstraints(
          minHeight: double.infinity,
        ),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Color.fromARGB(255, 166, 197, 227),
              Color.fromARGB(255, 233, 242, 243),
            ],
          ),
        ),
        child: NewInterestItem(
          title: title,
          controller: _interestController,
          onAddInterest: addInterest,
          onClearInterests: clearInterests,
        ),
      ),
    );
  }

  void _addInterest(String? interest) {
    if (interest != null || interest!.isNotEmpty) {
      interest = interest.trim();
      if (interest != '') {
        final isValidInterest = textRegex.hasMatch(interest);
        if (isValidInterest) {
          setState(() {
            _currentUser.interests.add(interest!);
          });
        } /* else {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Invalid input'),
              content: const Text(
                  'Please make sure a valid name of interest must be no longer then 30 characters and includes only letters, numbers, spaces and symbols , . - '),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(
                        ctx);
                  },
                  child: const Text('Ok'),
                )
              ],
            ),
          );
        } */
      }
    }
    _interestController.clear();
    Navigator.pop(context);
  }

  void _addPotentialInterest(String? interest) {
    if (interest != null) {
      interest = interest.trim();
      if (interest != '') {
        if (interest.isNotEmpty) {
          final isValidInterest = textRegex.hasMatch(interest);
          if (isValidInterest) {
            setState(() {
              _currentUser.potentialInterests.add(interest!);
            });
          }
        }
      }
    }
    _interestController.clear();
    Navigator.pop(context);
  }

  void _clearInterests() {
    setState(() {
      _currentUser.interests = [];
    });
    Navigator.pop(context);
  }

  void _clearPotentialInterests() {
    setState(() {
      _currentUser.potentialInterests = [];
    });
    Navigator.pop(context);
  }

  void _addLink() {
    setState(() {
      _currentUser.siteNames.add('');
      _currentUser.siteLinks.add('');
    });
  }

  void _saveSiteName(int index, String value) {
    setState(() {
      _currentUser.siteNames[index] = value;
    });
  }

  void _saveSiteLink(int index, String value) {
    setState(() {
      _currentUser.siteLinks[index] = value;
    });
  }

  void _deleteLink(int index) {
    setState(() {
      _currentUser.siteNames.removeAt(index);
      _currentUser.siteLinks.removeAt(index);
    });
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _saveData();
      _focusNodeName.unfocus();
      _focusNodeSurname.unfocus();
      _focusNodePosition.unfocus();
      _focusNodePhone.unfocus();
      _focusNodeEmail.unfocus();
      _focusNodeAddress.unfocus();
      _focusNodeDescription.unfocus();
      _focusNodeSiteName.unfocus();
      _focusNodeSiteLink.unfocus();
      isSucsessSave = true;
    }
  }

  void _resetProfile() {
    _loadData();
  }

  void _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(
      () {
        _savedData = prefs.getString('name');
        _nameController.text = _savedData ?? '';
        _currentUser.name = _nameController.text;
        _savedData = prefs.getString('surname');
        _surnameController.text = _savedData ?? '';
        _currentUser.surname =_surnameController.text;
        _savedData = prefs.getString('position');
        _positionController.text = _savedData ?? '';
        _currentUser.position = _positionController.text;
        _savedData = prefs.getString('phone');
        _phoneController.text = _savedData ?? '';
        _currentUser.phone = _phoneController.text;
        _savedData = prefs.getString('email');
        _emailController.text = _savedData ?? '';
        _currentUser.email = _emailController.text;
        _savedData = prefs.getString('address');
        _addressController.text = _savedData ?? '';
        _currentUser.address = _addressController.text;
        _savedData = prefs.getString('description');
        _descriptionController.text = _savedData ?? '';
        _currentUser.description = _descriptionController.text;
        _savedData = prefs.getString('profileType');
        _currentUser.profileType = _savedData ?? 'Private';
        _savedData = prefs.getString('interests');
        _savedInterests = _savedData ?? '';
        _currentUser.interests =
            _savedInterests == '' ? [] : _savedInterests.split(',').toList();
        _savedData = prefs.getString('potentialInterests');
        _savedPotentialInterests = _savedData ?? '';
        _currentUser.potentialInterests = _savedPotentialInterests == ''
            ? []
            : _savedPotentialInterests.split(',').toList();
        _savedData = prefs.getString('siteNames');
        _savedSiteNames = _savedData ?? '';
        _currentUser.siteNames =
            _savedSiteNames == '' ? [] : _savedSiteNames.split(',').toList();
        _savedData = prefs.getString('siteLinks');
        _savedSiteLinks = _savedData ?? '';
        _currentUser.siteLinks =
            _savedSiteLinks == '' ? [] : _savedSiteLinks.split(',').toList();
        _savedData = prefs.getString('image');
        _imagePath = _savedData ?? '';
        _image = _imagePath != '' ? File(_imagePath) : null;
      },
    );
  }

  void _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _currentUser.name);
    await prefs.setString('surname', _currentUser.surname);
    await prefs.setString('position', _currentUser.position);
    await prefs.setString('phone', _currentUser.phone);
    await prefs.setString('email', _currentUser.email);
    await prefs.setString('address', _currentUser.address);
    await prefs.setString('description', _currentUser.description);
    await prefs.setString('profileType', _currentUser.profileType);
    _savedInterests = _currentUser.interests.join(',').toString();
    await prefs.setString('interests', _savedInterests);
    _savedPotentialInterests = _currentUser.potentialInterests.join(',').toString();
    await prefs.setString('potentialInterests', _savedPotentialInterests);
    _savedSiteNames = _currentUser.siteNames.join(',').toString();
    await prefs.setString('siteNames', _savedSiteNames);
    _savedSiteLinks = _currentUser.siteLinks.join(',').toString();
    await prefs.setString('siteLinks', _savedSiteLinks);
    await prefs.setString('image', _imagePath);
  }

  Future<void> _pickImage() async {
    try {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final currentImage = File(pickedFile.path);
      final isValidateImage = await _validateImage(currentImage);
      if (isValidateImage) {
        setState(() {
          _image = currentImage;
        });

        _imagePath = _image!.path;
      }
    }
    }
    // ignore: empty_catches
    catch(e){}
  }

  Future<bool> _validateImage(File imageFile) async {
    const List<String> allowedFormats = ['jpg', 'jpeg', 'png'];
    const int maxSize = 5 * 1024 * 1024;

    if (await imageFile.length() > maxSize) {
      return false;
    }

    final String fileExtension = imageFile.path.split('.').last.toLowerCase();
    if (!allowedFormats.contains(fileExtension)) {
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _positionController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _descriptionController.dispose();
    _interestController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          Center(
            child: _image == null
                ? IconButton(
                    iconSize: 40,
                    onPressed: _pickImage,
                    icon: const Icon(Icons.add_a_photo_outlined),
                  )
                : GestureDetector(
                    onTap: _pickImage,
                    child: ClipOval(
                      child: Image.file(_image!,
                          width: 120, height: 120, fit: BoxFit.cover),
                    ),
                  ),
          ),

          const SizedBox(
            height: 20,
          ),

          TextFormField(
            controller: _nameController,
            focusNode: _focusNodeName,
            decoration: const InputDecoration(
              hintText: 'Name',
            ),
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  value.trim().length < 2 ||
                  value.trim().length > 50) {
                return 'Name must be between 2 and 50 characters';
              } else if (!strictRegex.hasMatch(value)) {
                return 'Only letters and spaces';
              }
              return null;
            },
            onSaved: (value) {
              _currentUser.name = value!;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _surnameController,
            focusNode: _focusNodeSurname,
            decoration: const InputDecoration(
              hintText: 'Surname',
            ),
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  value.trim().length < 2 ||
                  value.trim().length > 50) {
                return 'Surame must be between 2 and 50 characters';
              } else if (!strictRegex.hasMatch(value)) {
                return 'Only letters and spaces';
              }
              return null;
            },
            onSaved: (value) {
              _currentUser.surname = value!;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _positionController,
            focusNode: _focusNodePosition,
            decoration: const InputDecoration(
              hintText: 'Position',
            ),
            validator: (value) {
              if (value != '') {
                if (value!.trim().length < 2 || value.trim().length > 100) {
                  return 'Position must be between 2 and 100 characters';
                } else if (!regex.hasMatch(value)) {
                  return 'Only letters, numbers and spaces';
                }
              }
              return null;
            },
            onSaved: (value) {
              if (value != null) {
                _currentUser.position = value;
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _phoneController,
            focusNode: _focusNodePhone,
            decoration: const InputDecoration(
              hintText: 'Phone number',
            ),
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  value.trim().length < 10 ||
                  value.trim().length > 15) {
                return 'Phone must be between 10 and 15 characters';
              } else if (!phoneRegex.hasMatch(value)) {
                return 'Phone starts with + and contains only numbers';
              }
              return null;
            },
            onSaved: (value) {
              _currentUser.phone = value!;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _emailController,
            focusNode: _focusNodeEmail,
            decoration: const InputDecoration(
              hintText: 'Email',
            ),
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  value.trim().length < 3 ||
                  value.trim().length > 50) {
                return 'Email must be between 3 and 50 characters';
              } else if (!emailRegex.hasMatch(value)) {
                return 'invalid email address';
              }
              return null;
            },
            onSaved: (value) {
              _currentUser.email = value!;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _addressController,
            focusNode: _focusNodeAddress,
            decoration: const InputDecoration(
              hintText: 'Address',
            ),
            validator: (value) {
              if (value != '') {
                if (value!.trim().length < 2 || value.trim().length > 200) {
                  return 'Position must be between 2 and 200 characters';
                } else if (!textRegex.hasMatch(value)) {
                  return 'Only letters, numbers, spaces and symbols , . - ';
                }
              }
              return null;
            },
            onSaved: (value) {
              if (value != null) {
                _currentUser.address = value;
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _descriptionController,
            focusNode: _focusNodeDescription,
            decoration: const InputDecoration(
              hintText: 'Description',
            ),
            validator: (value) {
              if (value != '') {
                if (value!.trim().length < 2 || value.trim().length > 200) {
                  return 'Position must be between 2 and 200 characters';
                } else if (!textRegex.hasMatch(value)) {
                  return 'Only letters, numbers, spaces and symbols , . - ';
                }
              }
              return null;
            },
            onSaved: (value) {
              if (value != null) {
                _currentUser.description = value;
              }
            },
          ),

          const SizedBox(
            height: 20,
          ),

          const Text(
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 18,
                color: Colors.black,
              ),
              'Show your profile in Launchpad?'),
          Row(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio<String>(
                      value: 'Private',
                      groupValue: _currentUser.profileType,
                      onChanged: _selectProfileType),
                  const Text(
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      'Private'),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio<String>(
                      value: 'Public',
                      groupValue: _currentUser.profileType,
                      onChanged: _selectProfileType),
                  const Text(
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      'Public'),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),

          Row(
            children: [
              Expanded(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Text(
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 18,
                          color: Colors.black,
                        ),
                        'The scopes of your interest:'),
                    ..._currentUser.interests.map((item) => InterestItem(item)),
                    IconButton(
                      color: const Color.fromARGB(255, 56, 136, 231),
                      iconSize: 28,
                      onPressed: () => _openAddInterestOverLay(
                          _addInterest, _clearInterests, 'interests'),
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Text(
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 18,
                          color: Colors.black,
                        ),
                        'Potential interests:'),
                    ..._currentUser.potentialInterests
                        .map((item) => InterestItem(item)),
                    IconButton(
                      color: const Color.fromARGB(255, 56, 136, 231),
                      iconSize: 28,
                      onPressed: () => _openAddInterestOverLay(
                          _addPotentialInterest,
                          _clearPotentialInterests,
                          'potential interests'),
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),

          const Text(
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 18,
                color: Colors.black,
              ),
              'Your links:'),
          ...List.generate(
            _currentUser.siteNames.length,
            (index) => SiteLinkItem(
              key: ValueKey(_currentUser.siteLinks[index]),
              index: index,
              onSaveSiteName: _saveSiteName,
              onSaveSiteLink: _saveSiteLink,
              onDeleteLink: _deleteLink,
              regex: strictRegex,
              savedSiteName: _currentUser.siteNames[index],
              savedSiteLink: _currentUser.siteLinks[index],
            ),
          ),

          IconButton(
            alignment: Alignment.centerLeft,
            color: const Color.fromARGB(255, 56, 136, 231),
            iconSize: 28,
            onPressed: _addLink,
            icon: const Icon(Icons.add),
          ),

          const SizedBox(
            height: 10,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: _resetProfile,
                child: const Text('Reset'),
              ),
              const SizedBox(
                width: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  _saveProfile();
                  if (isSucsessSave) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Profile successfully saved!'),
                      ),
                    );
                    isSucsessSave = false;
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
