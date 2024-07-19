// ignore_for_file: file_names

class Author {
  final String? firstName;
  final String? lastName;
  final String? fullname;
  final String? email;
  final String? phoneNumber;
  final String? profilePicture;

  Author({
    required this.firstName,
    required this.lastName,
    required this.fullname,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
  });
  factory Author.fromJson(Map<String, dynamic> json) => authorFromJson(json);

  Map<String, dynamic> toJson() => authorToJson(this);

  static Author authorFromJson(Map<String, dynamic> json) => Author(
        firstName: json["firstName"] ?? "",
        lastName: json["lastName"] ?? "",
        fullname: json["fullname"] ?? "",
        email: json["email"] ?? "",
        phoneNumber: json["phoneNumber"] ?? "",
        profilePicture: json["profilePicture"] ?? "",
      );

  Map<String, dynamic> authorToJson(Author instance) => <String, dynamic>{
        "firstName": instance.firstName,
        "lastName": instance.lastName,
        "fullname": instance.fullname,
        "email": instance.email,
        "phoneNumber": phoneNumber,
        "profilePicture": instance.profilePicture,
      };
  List<Object> get props => [
        firstName!,
        lastName!,
        fullname!,
        email!,
        phoneNumber!,
        profilePicture!,
      ];
}
