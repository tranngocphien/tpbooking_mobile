class RoomEntity {
  String id;
  String name;
  List<String> imgs;
  List<String> utils;
  List<String> benefit;
  int adults;
  int children;
  int cost;

  RoomEntity(
      {required this.id,
      required this.name,
      required this.imgs,
      required this.utils,
      required this.benefit,
      required this.adults,
      required this.children,
      required this.cost});

  factory RoomEntity.fromJson(Map<String, dynamic> json) {
    return RoomEntity(
        id: json["id"],
        name: json["name"],
        imgs: List<String>.from(json["imgs"].map((x) => x)),
        utils: List<String>.from(json["utils"].map((x) => x)),
        benefit: List<String>.from(json["benefit"].map((x) => x)),
        adults: json["adults"],
        children: json["children"],
        cost: json["cost"]);
  }
}
