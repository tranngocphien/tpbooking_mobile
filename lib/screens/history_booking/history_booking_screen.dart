import 'package:flutter/material.dart';
import 'package:tpbooking/screens/history_booking/history_booking_controller.dart';
import 'package:get/get.dart';

class BookingHistrory extends StatelessWidget {
  const BookingHistrory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HistoryBookingController historyBookingController =
        Get.find();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Lịch sử đặt phòng",
          style: TextStyle(color: Color(0xFF18b57e)),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xFF18b57e),
            )),
      ),
      body: Obx(() => historyBookingController.isLoading.value ? const Center(child: CircularProgressIndicator(),) : ListView(
          children: List.generate(
              historyBookingController.listBooking.length,
              (index) => Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(8),
                    width: size.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 120,
                          child: Column(
                            children: [
                              Image.network(
                                'http://${historyBookingController.listHotels[index].imgs[0]}',
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                historyBookingController.listHotels[index].name,
                                style: const TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: size.width - 180,
                                child: Text(
                                  historyBookingController
                                      .listRooms[index].name,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                )),
                            Text(
                                'Ngày bắt đầu ${historyBookingController.listBooking[index].startDay}'),
                            Text(
                                'Ngày kết thúc ${historyBookingController.listBooking[index].endDay}'),
                            const SizedBox(
                              height: 8,
                            ),
                            historyBookingController
                                        .listBooking[index].status ==
                                    0
                                ? Container()
                                : InkWell(
                                    onTap: (){
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) => AlertDialog(
                                          title: const Text('Xóa'),
                                          content: Text('Bạn có chắc chắn muốn hủy phòng ${historyBookingController
                                              .listRooms[index].name}'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.pop(context, 'Cancel'),
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                await historyBookingController.cancelBooking(index);
                                                Navigator.pop(context);
                                              },
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: const BoxDecoration(
                                          color: Colors.deepOrangeAccent,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      child: const Text(
                                        "Hủy phòng",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )
                          ],
                        )
                      ],
                    ),
                  )))),
    );
  }
}
