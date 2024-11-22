class ProfileModel {
  ProfileModel(
      {required this.name,
      required this.surname,
      this.position = '',
      required this.phone,
      required this.email,
      this.address = '',
      this.description = '',
      });

  String name;
  String surname;
  String position;
  String phone;
  String email;
  String address;
  String description;
}
