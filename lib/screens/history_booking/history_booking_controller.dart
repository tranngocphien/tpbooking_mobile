import 'package:shared_preferences/shared_preferences.dart';
import 'package:tpbooking/models/booking_history_entity.dart';
import 'package:get/get.dart';
import 'package:tpbooking/models/hotel_entity.dart';
import 'package:tpbooking/models/room_entity.dart';
import 'package:tpbooking/services/hotel_service.dart';

class HistoryBookingController extends GetxController {
  final List<BookingHistoryEntity> listBooking =
      List<BookingHistoryEntity>.empty().obs;
  final List<Hotel> listHotels = List<Hotel>.empty().obs;
  final List<RoomEntity> listRooms = List<RoomEntity>.empty().obs;
  final _hotelService = HotelServices.instance;
  final isLoading = true.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    isLoading.value = true;
    await getListBooking();
    isLoading.value = false;
    super.onInit();
  }

  Future<void> getListBooking() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId') ?? 0;
    listBooking.clear();
    listBooking.addAll(await _hotelService.getListBooking(userId));
    listHotels.clear();

    for (var element in listBooking) {
      Hotel hotel = await _hotelService.getHotelById(element.hotelId);
      listHotels.add(hotel);
      for(RoomEntity room in hotel.rooms){
        if(room.id == element.roomId){
          listRooms.add(room);
          break;
        }
      }
    }
  }

}
