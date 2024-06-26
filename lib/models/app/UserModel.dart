// ignore_for_file: file_names

class UserModel {
  String? id;
  String? email;
  String? role;
  String? address;
  String? phoneNumber;
  String? position;
  String? fullname;

  UserModel({
    this.id,
    this.email,
    this.role,
    this.address,
    this.phoneNumber,
    this.position,
    this.fullname,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        email: json["email"],
        role: json["role"],
        address: json["address"],
        phoneNumber: json["phoneNumber"],
        position: json["position"],
        fullname: json["fullname"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "role": role,
        "address": address,
        "phoneNumber": phoneNumber,
        "position": position,
        "fullname": fullname,
      };
}
