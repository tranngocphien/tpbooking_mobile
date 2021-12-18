
import 'package:get/get.dart';
import 'package:tpbooking/models/hotel_entity.dart';
import 'package:tpbooking/services/api_services.dart';
import 'package:tpbooking/services/dio/dio_service.dart';

class HomeController extends GetxController{
  var dio = DioService.instance.get();
  var isLoading = true.obs;

  var listHotel = List<Hotel>.empty(growable: true).obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getHotels();
  }

  void getHotels() async{
    try {
      var hotels = await HotelServices.fetchHotels();
      if( hotels!= null){
        listHotel.addAll(hotels);
        print("length: ${listHotel.length}");
      }
    }
    finally {
      isLoading(false);

    }
  }
}