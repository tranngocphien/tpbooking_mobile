import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:tpbooking/models/hotel_entity.dart';
import 'package:tpbooking/models/room_entity.dart';
import 'package:tpbooking/screens/hotel/hotel_comment_controller.dart';
import 'package:tpbooking/screens/login/login_controller.dart';
import 'package:tpbooking/screens/room/room_screen.dart';
import 'package:get/get.dart';
import 'package:tpbooking/utils/utils.dart';

class HotelDetail extends StatelessWidget {
  final Hotel hotel;
  const HotelDetail({Key? key, required this.hotel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _commentController = TextEditingController();

    HotelCommentController commentController =
        Get.put(HotelCommentController(hotel.id), tag: hotel.id);
    LoginController loginController = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "THÔNG TIN KHÁCH SẠN",
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
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageHotel(
                  imgs: hotel.imgs,
                ),
                BaseInformation(hotel: hotel),
                Score(hotel: hotel),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Danh sách phòng",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                      const SizedBox(
                        height: 8,
                      ),
                      Column(
                        children:
                            hotel.rooms.map((e) => Room(room: e)).toList(),
                      )
                    ],
                  ),
                ),
                Obx(
                  () => Container(
                    margin: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Danh sách bình luận",
                          style: TextStyle(fontSize: 16),
                        ),
                        ...commentController.comments.map((e) => Container(
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.only(top: 8),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.grey)),
                              child: Row(
                                children: [
                                  Text(
                                    e.userName,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(e.content)
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  thickness: 2,
                ),
                loginController.isLogin.value
                    ? Container(
                        color: const Color(0xFF18b57e),
                        padding: const EdgeInsets.all(8),
                        child: Material(
                          elevation: 10.0,
                          borderRadius: BorderRadius.circular(30.0),
                          shadowColor: const Color(0x55434343),
                          child: TextField(
                            controller: _commentController,
                            textAlign: TextAlign.start,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: const InputDecoration(
                              hintText: "Bình luận",
                              prefixIcon: Icon(
                                Icons.comment,
                                color: Colors.black54,
                              ),
                              border: InputBorder.none,
                            ),
                            onSubmitted: (value) {
                              print(_commentController.text);
                              commentController.addComments(_commentController.text);

                            },
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Room extends StatelessWidget {
  final RoomEntity room;
  const Room({
    Key? key,
    required this.room,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RoomScreen(roomEntity: room)),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(top: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 140,
              height: 160,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage("https://${room.imgs[0]}"))),
            ),
            const SizedBox(
              width: 4,
            ),
            SizedBox(
              width: size.width - 140 - 16 - 16 - 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    room.name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: room.benefit.map((e) => Text(e)).toList(),
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${room.adults} người lớn"),
                          Text("${room.children} trẻ nhỏ")
                        ],
                      ),
                      Text(MoneyFormat.convertDoubleToString(room.cost * 1.0), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.redAccent),)
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Score extends StatelessWidget {
  const Score({
    Key? key,
    required this.hotel,
  }) : super(key: key);

  final Hotel hotel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Đánh giá tống thể",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    height: 48,
                    width: 48,
                    decoration: const BoxDecoration(
                        color: Colors.yellow, shape: BoxShape.circle),
                    child: Center(
                      child: Text(
                        hotel.score.toString(),
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Text("${hotel.scoreCount} đánh giá"),
                ],
              ),
              Column(children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 100,
                      child: Text("Độ sạch sẽ"),
                    ),
                    SizedBox(
                      width: 50,
                      child: Text(hotel.scoreClean.toString()),
                    )
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 100,
                      child: Text("Vị trí"),
                    ),
                    SizedBox(
                      width: 50,
                      child: Text(hotel.scoreClean.toString()),
                    )
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 100,
                      child: Text("Dịch vụ"),
                    ),
                    SizedBox(
                      width: 50,
                      child: Text(hotel.scoreClean.toString()),
                    )
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 100,
                      child: Text("Tiện nghi"),
                    ),
                    SizedBox(
                      width: 50,
                      child: Text(hotel.scoreClean.toString()),
                    )
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 100,
                      child: Text("Đáng giá tiền"),
                    ),
                    SizedBox(
                      width: 50,
                      child: Text(hotel.scoreClean.toString()),
                    )
                  ],
                )
              ])
            ],
          )
        ],
      ),
    );
  }
}

class BaseInformation extends StatelessWidget {
  const BaseInformation({
    Key? key,
    required this.hotel,
  }) : super(key: key);

  final Hotel hotel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hotel.name,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(flex: 3, child: Text(hotel.address)),
              Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(hotel.score.toString()),
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      )
                    ],
                  ))
            ],
          ),
          Divider(
            thickness: 1,
          )
        ],
      ),
    );
  }
}

class ImageHotel extends StatelessWidget {
  final List<String> imgs;
  const ImageHotel({Key? key, required this.imgs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: ImageSlideshow(
          children: imgs.map((e) => Image.network("https://${e}")).toList()),
    );
  }
}
