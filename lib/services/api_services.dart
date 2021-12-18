import 'package:tpbooking/models/hotel_entity.dart';
import 'package:tpbooking/services/dio/dio_service.dart';

class HotelServices {
  static var dio = DioService.instance.get();

  static Future<List<Hotel>> fetchHotels() async{
    var response = await dio.get("http://192.168.1.16:8080/home");
    if(response.statusCode == 200){
      return response.data["data"].map<Hotel>((json) => Hotel.fromJson(json)).toList();
    }
    return List<Hotel>.empty(growable: true);

  }

  static Future<List<Hotel>> searchHotels(String key) async{
    var data = {
      "page": 0,
      "text": key
    };
    var response = await dio.post("http://192.168.1.16:8080/home/search", data: data);
    if(response.statusCode == 200){
      print("a");
      return response.data["data"].map<Hotel>((json) => Hotel.fromJson(json)).toList();

    }
    return List<Hotel>.empty(growable: true);
  }

}