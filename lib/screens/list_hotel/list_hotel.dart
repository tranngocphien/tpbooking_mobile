import 'package:flutter/material.dart';
import 'package:tpbooking/models/hotel_entity.dart';
import 'package:tpbooking/screens/hotel/hotel_screen.dart';
import 'package:tpbooking/services/hotel_service.dart';

class ListHotelScreen extends StatefulWidget {
  final String searchKey;
  const ListHotelScreen({Key? key, required this.searchKey}) : super(key: key);

  @override
  State<ListHotelScreen> createState() => _ListHotelScreenState();
}

class _ListHotelScreenState extends State<ListHotelScreen> {
  List<Hotel> hotels = List<Hotel>.empty(growable: true);
  late Future<List<Hotel>> hotelFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hotelFuture = HotelServices.searchHotels(widget.searchKey);
    // Future<List<Hotel>> result = HotelServices.searchHotels(widget.searchKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "TÌM KIẾM",
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
        child: Container(
          padding: EdgeInsets.all(8),
          width: double.infinity,
          child: Column(
            children: [
              const Text(
                "Danh sách các khách sạn",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: FutureBuilder<List<Hotel>>(
                future: hotelFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return HotelTile(hotel: snapshot.data![index]);
                        });
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  // By default, show a loading spinner.
                  return const Center(child: CircularProgressIndicator());
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class HotelTile extends StatelessWidget {
  final Hotel hotel;
  const HotelTile({
    Key? key,
    required this.hotel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HotelDetail(hotel: hotel)),
        );
      },
      child: Card(
        child: SizedBox(
          width: double.infinity,
          height: 160,
          child: Row(
            children: [
              Container(
                width: 140,
                height: 160,
                decoration:  BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            "https://${hotel.imgs[0]}"))),
              ),
              Container(
                width: size.width - 160 - 16,
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hotel.name,
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 4,),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 16,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(hotel.city)
                          ],
                        ),
                      ],
                    ),


                    Row(
                      children: [
                        Text(
                          hotel.score.toString(),
                          style: const TextStyle(
                              color: Colors.orangeAccent,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        const Icon(Icons.star, color: Colors.yellow,)
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
