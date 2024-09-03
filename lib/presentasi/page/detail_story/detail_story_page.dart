import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_app/presentasi/provider/story/story_data_provider.dart';
import 'package:story_app/presentasi/router/router_provider.dart';

class DetailStoryPage extends ConsumerStatefulWidget {
  final String id;

  const DetailStoryPage(this.id, {super.key});

  @override
  ConsumerState<DetailStoryPage> createState() => _DetailStoryPageState();
}

class _DetailStoryPageState extends ConsumerState<DetailStoryPage> {
  // final dicodingOffice = const LatLng(-6.8957473, 107.6337669);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Story"),
      ),
      body: FutureBuilder(
        future: ref.watch(dataStoryProvider.notifier).getDetail(id: widget.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!.story;
            return ListView(
              physics: const ScrollPhysics(),
              children: [
                Image.network(data!.photoUrl, height: height * 0.3),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.02),
                      const Text(
                        "Deskripsi",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: height * 0.01),
                      Row(
                        children: [
                          const Text(
                            "Name :",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            data.name,
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.02),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Deskripsi",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        data.description,
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: height * 0.02),
                      const Text(
                        "Location",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      data.lat == null
                          ? const SizedBox(
                              child: Text(
                                "data tidak ada location",
                              ),
                            )
                          : ElevatedButton(
                              onPressed: () {
                                ref.read(routerProvider).pushNamed(
                                  "Location",
                                  extra: {
                                    "lat": data.lat.toString(),
                                    "long": data.lon.toString(),
                                    "name": data.name
                                  },
                                );
                              },
                              child: const Text(
                                "View Location",
                                style: TextStyle(fontSize: 20),
                              ),
                            )
                      // SizedBox(
                      //     height: height * 0.3,
                      //     child: Stack(
                      //       children: [
                      //         GoogleMap(
                      //           initialCameraPosition: CameraPosition(
                      //             zoom: 18,
                      //             target: LatLng(data.lat, data.lon),
                      //           ),
                      //           markers: ref
                      //               .watch(dataStoryProvider.notifier)
                      //               .markers,
                      //           zoomControlsEnabled: false,
                      //           mapToolbarEnabled: false,
                      //           myLocationButtonEnabled: false,
                      //           myLocationEnabled: true,
                      //           onMapCreated: (controller) async {
                      //             final info =
                      //                 await geo.placemarkFromCoordinates(
                      //                     data.lat, data.lon);

                      //             final place = info[0];
                      //             final street = place.street!;
                      //             final address =
                      //                 '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
                      //             ref
                      //                 .read(dataStoryProvider.notifier)
                      //                 .placemark = place;
                      //             ref
                      //                 .read(dataStoryProvider.notifier)
                      //                 .defineMarker(
                      //                     LatLng(data.lat, data.lon),
                      //                     street,
                      //                     address);
                      //             ref
                      //                 .read(dataStoryProvider.notifier)
                      //                 .mapController = controller;
                      //             setState(() {});
                      //           },
                      //           onLongPress: (LatLng latLng) {
                      //             ref
                      //                 .read(dataStoryProvider.notifier)
                      //                 .onLongPressGoogleMap(latLng);
                      //           },
                      //         ),
                      //         Positioned(
                      //           bottom: 16,
                      //           right: 16,
                      //           child: FloatingActionButton(
                      //             child: const Icon(Icons.my_location),
                      //             onPressed: () {
                      //               ref
                      //                   .read(dataStoryProvider.notifier)
                      //                   .onMyLocationButtonPress();
                      //               setState(() {});
                      //             },
                      //           ),
                      //         ),
                      //         if (ref
                      //                 .read(dataStoryProvider.notifier)
                      //                 .placemark ==
                      //             null)
                      //           const SizedBox()
                      //         else
                      //           Positioned(
                      //             top: 10,
                      //             right: 16,
                      //             left: 16,
                      //             child: PlacemarkWidget(
                      //               placemark: ref
                      //                   .read(dataStoryProvider.notifier)
                      //                   .placemark!,
                      //             ),
                      //           ),
                      //       ],
                      //     ),
                      //   ),
                    ],
                  ),
                )
              ],
            );
          } else {
            return const Center(
              child: Text("data Kosong"),
            );
          }
        },
      ),
    );
  }
}
