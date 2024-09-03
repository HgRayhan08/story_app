import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_app/presentasi/provider/story/story_data_provider.dart';

import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:story_app/presentasi/router/router_provider.dart';

class FormCreateStoryPage extends ConsumerStatefulWidget {
  const FormCreateStoryPage({super.key});

  @override
  ConsumerState<FormCreateStoryPage> createState() =>
      _FormCreateStoryPageState();
}

class _FormCreateStoryPageState extends ConsumerState<FormCreateStoryPage> {
  bool _isLoading = false;
  bool location = false;
  final TextEditingController descriptionController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;

//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             ref.read(routerProvider).goNamed("Home");
//           },
//           icon: const Icon(Icons.arrow_back_ios),
//         ),
//         title: const Text(
//           "Create Story",
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: ListView(
//         padding: EdgeInsets.symmetric(horizontal: width * 0.05),
//         children: [
//           Container(
//             padding: const EdgeInsets.all(10),
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.width * 0.5,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               border: Border.all(),
//               borderRadius: const BorderRadius.all(
//                 Radius.circular(20),
//               ),
//             ),
//             child: ref.watch(dataStoryProvider.notifier).photo != null
//                 ? Image.file(
//                     File(ref.watch(dataStoryProvider.notifier).photo!.path),
//                     fit: BoxFit.cover,
//                   )
//                 : const Center(
//                     child: Icon(
//                       Icons.image,
//                       size: 150,
//                     ),
//                   ),
//           ),
//           SizedBox(height: height * 0.02),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                 onPressed: () async {
//                   await ref.read(dataStoryProvider.notifier).onCameraView();
//                   setState(() {});
//                 },
//                 child: const Text("Camera"),
//               ),
//               SizedBox(width: width * 0.05),
//               ElevatedButton(
//                 onPressed: () async {
//                   await ref.read(dataStoryProvider.notifier).onGalleriView();
//                   setState(() {});
//                 },
//                 child: const Text("Galery"),
//               ),
//             ],
//           ),
//           SizedBox(height: height * 0.015),
//           SizedBox(
//             height: height * 0.2,
//             width: width,
//             child: TextFormField(
//               maxLines: null,
//               expands: true,
//               controller: descriptionController,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: height * 0.03),
//           const Align(
//             alignment: Alignment.center,
//             child: Text(
//               "Location",
//               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 "off",
//                 style: TextStyle(fontSize: 25),
//               ),
//               Switch(
//                 // This bool value toggles the switch.
//                 value: location,
//                 activeColor: Colors.blue,
//                 onChanged: (bool value) {
//                   setState(() {
//                     location = value;
//                   });
//                 },
//               ),
//               const Text(
//                 "on",
//                 style: TextStyle(fontSize: 25),
//               )
//             ],
//           ),
//           SizedBox(height: height * 0.02),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               padding: EdgeInsets.symmetric(vertical: height * 0.01),
//               backgroundColor: Colors.blue[400],
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//             ),
//             onPressed: _isLoading ? null : _logic,
//             child: _isLoading
//                 ? const CircularProgressIndicator(
//                     color: Colors.white,
//                   )
//                 : const Text(
//                     "Upload",
//                     style: TextStyle(color: Colors.white, fontSize: 20),
//                   ),
//           ),
//         ],
//       ),
//     );
//   }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: ref.watch(dataStoryProvider.notifier).getCurrentLocation(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: ref.watch(dataStoryProvider.notifier).photo != null
                      ? Image.file(
                          File(ref
                              .watch(dataStoryProvider.notifier)
                              .photo!
                              .path),
                          fit: BoxFit.cover,
                        )
                      : const Center(
                          child: Icon(
                            Icons.image,
                            size: 150,
                          ),
                        ),
                ),
                SizedBox(height: height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await ref
                            .read(dataStoryProvider.notifier)
                            .onCameraView();
                        setState(() {});
                      },
                      child: const Text("Camera"),
                    ),
                    SizedBox(width: width * 0.05),
                    ElevatedButton(
                      onPressed: () async {
                        await ref
                            .read(dataStoryProvider.notifier)
                            .onGalleriView();
                        setState(() {});
                      },
                      child: const Text("Galery"),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.015),
                SizedBox(
                  height: height * 0.2,
                  width: width,
                  child: TextFormField(
                    maxLines: null,
                    expands: true,
                    controller: descriptionController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.03),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Location",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "off",
                      style: TextStyle(fontSize: 25),
                    ),
                    Switch(
                      // This bool value toggles the switch.
                      value: location,
                      activeColor: Colors.blue,
                      onChanged: (bool value) {
                        setState(() {
                          location = value;
                        });
                      },
                    ),
                    const Text(
                      "on",
                      style: TextStyle(fontSize: 25),
                    )
                  ],
                ),
                location == false
                    ? Container()
                    : SizedBox(
                        height: height * 0.5,
                        child: Stack(
                          children: [
                            GoogleMap(
                              initialCameraPosition: CameraPosition(
                                zoom: 18,
                                target: LatLng(data!.latitude, data.longitude),
                              ),
                              markers:
                                  ref.watch(dataStoryProvider.notifier).markers,
                              zoomControlsEnabled: false,
                              mapToolbarEnabled: false,
                              myLocationButtonEnabled: false,
                              myLocationEnabled: true,
                              onMapCreated: (controller) async {
                                final info = await geo.placemarkFromCoordinates(
                                    data.latitude, data.longitude);

                                final place = info[0];
                                final street = place.street!;
                                final address =
                                    '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

                                setState(() {
                                  ref
                                      .watch(dataStoryProvider.notifier)
                                      .placemark = place;
                                });

                                defineMarker(
                                    LatLng(data.latitude, data.longitude),
                                    street,
                                    address);

                                setState(() {
                                  ref
                                      .watch(dataStoryProvider.notifier)
                                      .mapController = controller;
                                });
                              },
                              onLongPress: (LatLng latLng) =>
                                  onLongPressGoogleMap(latLng),
                            ),
                            Positioned(
                              top: 16,
                              right: 16,
                              child: FloatingActionButton(
                                child: const Icon(Icons.my_location),
                                onPressed: () => onMyLocationButtonPress(),
                              ),
                            ),
                            if (ref
                                    .watch(dataStoryProvider.notifier)
                                    .placemark ==
                                null)
                              const SizedBox()
                            else
                              Positioned(
                                bottom: 16,
                                right: 16,
                                left: 16,
                                child: PlacemarkWidget(
                                  placemark: ref
                                      .watch(dataStoryProvider.notifier)
                                      .placemark!,
                                ),
                              ),
                          ],
                        ),
                      ),
                SizedBox(height: height * 0.02),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: height * 0.01),
                    backgroundColor: Colors.blue[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: _isLoading ? null : _logic,
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          "Upload",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                ),
                SizedBox(height: height * 0.1),
              ],
            );
          } else {
            return const Center(
              child: Text("Data Kosong"),
            );
          }
        },
      ),
    );
  }

  void _logic() async {
    setState(() {
      _isLoading = true; // Tampilkan loading saat proses dimulai
    });

    bool create = await ref
        .read(dataStoryProvider.notifier)
        .create(description: descriptionController.text, location: location);

    setState(() {
      _isLoading = false; // Sembunyikan loading setelah proses selesai
    });

    if (create) {
      ref.read(routerProvider).pop(); // Kembali ke halaman sebelumnya
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to create story')),
      );
    }
  }

  /// todo-04-06: do reverse geocoding in onLongPressGoogleMap function
  void onLongPressGoogleMap(LatLng latLng) async {
    final info =
        await geo.placemarkFromCoordinates(latLng.latitude, latLng.longitude);

    final place = info[0];
    final street = place.street!;
    final address =
        '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

    setState(() {
      ref.watch(dataStoryProvider.notifier).placemark = place;
    });

    /// todo-03-02: set a marker based on new lat-long
    defineMarker(latLng, street, address);

    /// todo-03-03: animate a map view based on a new latLng
    ref.watch(dataStoryProvider.notifier).mapController.animateCamera(
          CameraUpdate.newLatLng(latLng),
        );
  }

  void onMyLocationButtonPress() async {
    /// todo-02-06: define a location variable
    final Location location = Location();
    late bool serviceEnabled;
    late PermissionStatus permissionGranted;
    late LocationData locationData;

    /// todo-02-07: check the location service
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        print("Location services is not available");
        return;
      }
    }

    /// todo-02-08: check the location permission
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        print("Location permission is denied");
        return;
      }
    }

    /// todo-02-09: get the current device location
    locationData = await location.getLocation();
    final latLng = LatLng(locationData.latitude!, locationData.longitude!);

    /// todo-04-03: run the reverse geocoding
    final info =
        await geo.placemarkFromCoordinates(latLng.latitude, latLng.longitude);

    /// todo-04-04: define a name and address of location
    final place = info[0];
    final street = place.street!;
    final address =
        '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

    setState(() {
      ref.watch(dataStoryProvider.notifier).placemark = place;
    });

    /// todo-02-10: set a marker
    /// todo-04-05: show the information of location's place and add new argument
    defineMarker(latLng, street, address);

    /// todo-02-11: animate a map view based on a new latLng
    ref.watch(dataStoryProvider.notifier).mapController.animateCamera(
          CameraUpdate.newLatLng(latLng),
        );
  }

  /// todo--02: define a marker based on a new latLng
  void defineMarker(LatLng latLng, String street, String address) {
    final marker = Marker(
      markerId: const MarkerId("source"),
      position: latLng,
      infoWindow: InfoWindow(
        title: street,
        snippet: address,
      ),
    );

    setState(() {
      ref.watch(dataStoryProvider.notifier).markers.clear();
      ref.watch(dataStoryProvider.notifier).markers.add(marker);
    });
  }
}

/// todo-05-01: create a location's place widget
class PlacemarkWidget extends StatelessWidget {
  const PlacemarkWidget({
    super.key,
    required this.placemark,
  });

  /// todo-05-02: create a variable
  final geo.Placemark placemark;

  @override
  Widget build(BuildContext context) {
    return Container(
      /// todo-05-03: show the information
      padding: const EdgeInsets.all(16),
      constraints: const BoxConstraints(maxWidth: 700),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 20,
            offset: Offset.zero,
            color: Colors.grey.withOpacity(0.5),
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  placemark.street!,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  '${placemark.subLocality}, ${placemark.locality}, ${placemark.postalCode}, ${placemark.country}',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
