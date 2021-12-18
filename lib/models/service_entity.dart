class ServiceEntity{
  String name;
  List<String> services;

  ServiceEntity({required this.name, required this.services});
  
  factory ServiceEntity.fromJson(Map<String, dynamic> json){
    return ServiceEntity(name: json["name"], services: List<String>.from(json["service"].map((x) => x)));
  }
}