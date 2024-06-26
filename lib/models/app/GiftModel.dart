// ignore_for_file: file_names

class GiftModel {
  final String image;
  final String name;
  final int coins;

  GiftModel({
    required this.image,
    required this.name,
    required this.coins,
  });

  factory GiftModel.fromJson(Map<String, dynamic> json) {
    return GiftModel(
      image: json['image'] ?? '',
      name: json['name'] ?? '',
      coins: json['coins'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'name': name,
      'coins': coins,
    };
  }
}
