import 'package:get/get.dart';
import 'package:tpbooking/models/hotel_entity.dart';
import 'package:tpbooking/services/hotel_service.dart';

class HomeController extends GetxController{
  var isLoading = true.obs;
  final _hotelService = HotelServices.instance;
  var listHotel = List<Hotel>.empty(growable: true).obs;

  @override
  void onInit() async{
    // TODO: implement onInit
    isLoading.value = true;
    await getHotels();
    isLoading.value = false;
    super.onInit();
  }

  Future<void> getHotels() async{
      var hotels = await _hotelService.fetchHotels();
      listHotel.clear();
      listHotel.addAll(hotels);
  }
}
