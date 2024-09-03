import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserLocationPage extends StatefulWidget {
  final String lat;
  final String long;
  final String name;

  const UserLocationPage(
      {super.key, required this.lat, required this.long, required this.name});

  @override
  State<UserLocationPage> createState() => _UserLocationPageState();
}

class _UserLocationPageState extends State<UserLocationPage> {
  late LatLng latLong;
  late GoogleMapController mapController;

  bool mouted = false;
  String address = "";

  void _getAddress() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        double.parse(widget.lat), double.parse(widget.long));

    var mergeAddress =
        "${placemarks.first.street}, ${placemarks.first.subLocality}, ${placemarks.first.locality}, ${placemarks.first.administrativeArea}, ${placemarks.first.country}, ${placemarks.first.postalCode}";

    setState(() {
      address = mergeAddress;
    });
  }

  @override
  void initState() {
    latLong = LatLng(double.parse(widget.lat), double.parse(widget.long));
    mouted = true;

    Future.microtask(() => _getAddress());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Location User",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
            child: mouted
                ? Stack(
                    children: [
                      GoogleMap(
                          onMapCreated: (controller) {
                            setState(() {
                              mapController = controller;
                            });
                          },
                          initialCameraPosition:
                              CameraPosition(target: latLong, zoom: 15),
                          markers: {
                            Marker(
                                markerId: MarkerId(widget.name),
                                onTap: () {
                                  mapController.animateCamera(
                                    CameraUpdate.newLatLngZoom(latLong, 18),
                                  );
                                },
                                position: latLong,
                                infoWindow: InfoWindow(
                                    title: widget.name,
                                    snippet: "${widget.lat}, ${widget.long}")),
                          }),
                      address.isNotEmpty
                          ? Positioned(
                              bottom: 20,
                              left: 0,
                              right: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            blurRadius: 6,
                                            offset: const Offset(0, 3))
                                      ]),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        address,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox()
                    ],
                  )
                : const CircularProgressIndicator()));
  }
}
