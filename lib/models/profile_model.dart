class ProfileModel {
  ProfileModel(
      {required this.name,
      required this.surname,
      this.position = '',
      required this.phone,
      required this.email,
      this.address = '' ,
      this.description = '',
      required this.interests,
      required this.potentialInterests,
      required this.profileType,
      required this.siteNames,
      required this.siteLinks,
      });

  String name;
  String surname;
  String position;
  String phone;
  String email;
  String address;
  String description;
  List<String> interests;
  List<String> potentialInterests;
  String profileType;
  List<String> siteNames;
  List<String> siteLinks;
}
