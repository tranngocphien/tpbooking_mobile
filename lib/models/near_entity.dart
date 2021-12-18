class NearEntity {
  String name;
  int distance;

  NearEntity({required this.name, required this.distance});

  factory NearEntity.fromJson(Map<String, dynamic> json){
    return NearEntity(name: json["name"], distance: json["distance"] == null? 0: json["distance"]);
  }

}
