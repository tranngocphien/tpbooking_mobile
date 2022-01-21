import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:tpbooking/models/room_entity.dart';
import 'package:tpbooking/screens/booking/booking_screen.dart';
import 'package:tpbooking/utils/utils.dart';

class RoomScreen extends StatelessWidget {
  final RoomEntity roomEntity;
  const RoomScreen({Key? key, required this.roomEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "THÔNG TIN PHÒNG",
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageRoom(imgs: roomEntity.imgs),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  roomEntity.name,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 8,
                ),
                Center(
                    child: Text(
                      '${MoneyFormat.convertDoubleToString(roomEntity.cost * 1.0)}',
                      style: const TextStyle(
                          color: Color(0xFFde1616),
                          fontSize: 28,
                          fontWeight: FontWeight.w700),
                    )),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  width: 300,
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                      color: Color(0xFF18b57e),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: const Text(
                    "Điểm đặc trưng",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                      children: List.generate(
                          roomEntity.utils.length,
                          (index) => Row(
                                children: [
                                  const Icon(
                                    Icons.done_outline_sharp,
                                    color: Colors.greenAccent,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    roomEntity.utils[index],
                                    style: const TextStyle(fontSize: 16),
                                  )
                                ],
                              ))),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  width: 300,
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                      color: Color(0xFF18b57e),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: const Text(
                    "Tiện ích",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                      children: List.generate(
                          roomEntity.utils.length,
                          (index) => Container(
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.padding,
                                      color: Colors.greenAccent,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      roomEntity.utils[index],
                                      style: const TextStyle(fontSize: 16),
                                    )
                                  ],
                                ),
                              ))),
                ),
                const SizedBox(
                  height: 8,
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => BookingScreen(roomEntity: roomEntity)));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                        color: Color(0xFFed5c59),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: const Center(
                        child: Text(
                      'Đặt phòng ngay',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                    )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ImageRoom extends StatelessWidget {
  final List<String> imgs;
  const ImageRoom({Key? key, required this.imgs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: ImageSlideshow(
          children: imgs
              .map((e) => Image.network(
                    "https://${e}",
                    width: 1 / 2 * (size.width),
                    fit: BoxFit.contain,
                  ))
              .toList()),
    );
  }
}
