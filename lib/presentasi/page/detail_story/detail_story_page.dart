import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:story_app/presentasi/provider/story/story_data_provider.dart';
import 'package:story_app/presentasi/widget/deskripsi_widget.dart';
import 'package:story_app/presentasi/widget/plachmark_widget.dart';

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
                Image.network(data.photoUrl, height: height * 0.3),
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
                      data.lat == 0.0
                          ? const SizedBox(
                              child: Text(
                                "data tidak ada location",
                              ),
                            )
                          : SizedBox(
                              height: height * 0.3,
                              child: Stack(
                                children: [
                                  GoogleMap(
                                    initialCameraPosition: CameraPosition(
                                      zoom: 18,
                                      target: LatLng(data.lat, data.lon),
                                    ),
                                    markers: ref
                                        .watch(dataStoryProvider.notifier)
                                        .markers,
                                    zoomControlsEnabled: false,
                                    mapToolbarEnabled: false,
                                    myLocationButtonEnabled: false,
                                    myLocationEnabled: true,
                                    onMapCreated: (controller) async {
                                      final info =
                                          await geo.placemarkFromCoordinates(
                                              data.lat, data.lon);

                                      final place = info[0];
                                      final street = place.street!;
                                      final address =
                                          '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
                                      ref
                                          .read(dataStoryProvider.notifier)
                                          .placemark = place;
                                      ref
                                          .read(dataStoryProvider.notifier)
                                          .defineMarker(
                                              LatLng(data.lat, data.lon),
                                              street,
                                              address);
                                      ref
                                          .read(dataStoryProvider.notifier)
                                          .mapController = controller;
                                      setState(() {});
                                    },
                                    onLongPress: (LatLng latLng) {
                                      ref
                                          .read(dataStoryProvider.notifier)
                                          .onLongPressGoogleMap(latLng);
                                    },
                                  ),
                                  Positioned(
                                    bottom: 16,
                                    right: 16,
                                    child: FloatingActionButton(
                                      child: const Icon(Icons.my_location),
                                      onPressed: () {
                                        ref
                                            .read(dataStoryProvider.notifier)
                                            .onMyLocationButtonPress();
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                  if (ref
                                          .read(dataStoryProvider.notifier)
                                          .placemark ==
                                      null)
                                    const SizedBox()
                                  else
                                    Positioned(
                                      top: 10,
                                      right: 16,
                                      left: 16,
                                      child: PlacemarkWidget(
                                        placemark: ref
                                            .read(dataStoryProvider.notifier)
                                            .placemark!,
                                      ),
                                    ),
                                ],
                              ),
                            ),
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

  /// todo-04-06: do reverse geocoding in onLongPressGoogleMap function
//   void onLongPressGoogleMap(LatLng latLng) async {
//     final info =
//         await geo.placemarkFromCoordinates(latLng.latitude, latLng.longitude);

//     final place = info[0];
//     final street = place.street!;
//     final address =
//         '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

//     setState(() {
//       placemark = place;
//     });

//     /// todo-03-02: set a marker based on new lat-long
//     defineMarker(latLng, street, address);

//     /// todo-03-03: animate a map view based on a new latLng
//     mapController.animateCamera(
//       CameraUpdate.newLatLng(latLng),
//     );
//   }

//   void onMyLocationButtonPress() async {
//     /// todo-02-06: define a location variable
//     final Location location = Location();
//     late bool serviceEnabled;
//     late PermissionStatus permissionGranted;
//     late LocationData locationData;

//     /// todo-02-07: check the location service
//     serviceEnabled = await location.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await location.requestService();
//       if (!serviceEnabled) {
//         print("Location services is not available");
//         return;
//       }
//     }

//     /// todo-02-08: check the location permission
//     permissionGranted = await location.hasPermission();
//     if (permissionGranted == PermissionStatus.denied) {
//       permissionGranted = await location.requestPermission();
//       if (permissionGranted != PermissionStatus.granted) {
//         print("Location permission is denied");
//         return;
//       }
//     }

//     /// todo-02-09: get the current device location
//     locationData = await location.getLocation();
//     final latLng = LatLng(locationData.latitude!, locationData.longitude!);

//     /// todo-04-03: run the reverse geocoding
//     final info =
//         await geo.placemarkFromCoordinates(latLng.latitude, latLng.longitude);

//     /// todo-04-04: define a name and address of location
//     final place = info[0];
//     final street = place.street!;
//     final address =
//         '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

//     setState(() {
//       placemark = place;
//     });

//     /// todo-02-10: set a marker
//     /// todo-04-05: show the information of location's place and add new argument
//     defineMarker(latLng, street, address);

//     /// todo-02-11: animate a map view based on a new latLng
//     mapController.animateCamera(
//       CameraUpdate.newLatLng(latLng),
//     );
//   }

//   /// todo--02: define a marker based on a new latLng
//   void defineMarker(LatLng latLng, String street, String address) {
//     final marker = Marker(
//       markerId: const MarkerId("source"),
//       position: latLng,
//       infoWindow: InfoWindow(
//         title: street,
//         snippet: address,
//       ),
//     );

//     /// todo--03: clear and add a new marker
//     setState(() {
//       markers.clear();
//       markers.add(marker);
//     });
//   }
// }

  /// todo-05-01: create a location's place widget
}
