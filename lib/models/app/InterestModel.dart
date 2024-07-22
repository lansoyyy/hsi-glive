// ignore_for_file: file_names

class InterestModel {
  final String id;
  final String name;
  final dynamic parent;
  final String type;
  final int v;
  final String interestModelId;

  InterestModel({
    required this.id,
    required this.name,
    required this.parent,
    required this.type,
    required this.v,
    required this.interestModelId,
  });
  factory InterestModel.fromJson(Map<String, dynamic> json) => interestModelFromJson(json);

  Map<String, dynamic> toJson() => interestModelToJson(this);

  static InterestModel interestModelFromJson(Map<String, dynamic> json) => InterestModel(
        id: json["_id"],
        name: json["name"],
        parent: json["parent"],
        type: json["type"],
        v: json["__v"],
        interestModelId: json["id"],
      );

  Map<String, dynamic> interestModelToJson(InterestModel instance) => <String, dynamic>{
        "_id": instance.id,
        "name": instance.name,
        "parent": instance.parent,
        "type": instance.type,
        "__v": instance.v,
        "id": instance.interestModelId,
      };
  List<Object> get props => [
        id,
        name,
        parent,
        type,
        v,
        interestModelId,
      ];
}
