import 'dart:typed_data';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image/image.dart' as img;

import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:story_app/domain/model/detail_story_model.dart';
import 'package:story_app/domain/usecase/create_story/create_story_usecase.dart';
import 'package:story_app/domain/usecase/create_story/story_params.dart';
import 'package:story_app/domain/usecase/get_detail_story/get_detail_story_usecase.dart';
import 'package:story_app/presentasi/provider/usecase/create_story_provider.dart';
import 'package:story_app/presentasi/provider/usecase/get_detail_story_provider.dart';

import 'package:geocoding/geocoding.dart' as geo;

part "story_data_provider.g.dart";

@Riverpod(keepAlive: true)
class DataStory extends _$DataStory {
  XFile? _photo;
  bool _isLoading = false;

  // final dicodingOffice = const LatLng(-6.8957473, 107.6337669);
  late GoogleMapController mapController;
  geo.Placemark? placemark;
  late final Set<Marker> markers = {};

  int? page = 1;
  int size = 5;

  XFile? get photo => _photo;
  bool get isLoading => _isLoading;

  @override
  FutureOr<String> build() {
    return "";
  }

  // Future<List<ListStory>> getstory() async {
  //   GetAllStoryUsecase story = ref.read(getAllStoryUsecaseProvider);
  //   var result = await story(null);
  //   if (result.error != true) {
  //     // return result.listStory;
  //     // Mengambil cerita dari indeks 0 hingga 4 (cerita sebelumnya)
  //     List<ListStory> firstPart = result.listStory.take(5).toList();

  //     // Mengambil cerita dari indeks 5 hingga 9 (cerita setelahnya)
  //     int endIndex =
  //         result.listStory.length < 10 ? result.listStory.length : 10;
  //     List<ListStory> secondPart = result.listStory.sublist(5, endIndex);

  //     // Menggabungkan kedua daftar cerita
  //     firstPart.addAll(secondPart);

  //     return firstPart;
  //   } else {
  //     throw Exception("Error fetching stories");
  //   }
  // }

  Future<bool> onGalleriView() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
      );
      _photo = pickedFile;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> onCameraView() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: ImageSource.camera,
      );

      if (pickedFile != null) {
        _photo = pickedFile;
      } else {
        throw Exception("Error get detail stories");
      }
    } catch (e) {
      throw Exception("Error get detail stories");
    }
  }

  Future<Position> getCurrentLocation() async {
    try {
      // Memeriksa izin lokasi
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Future.error('Location services are disabled.');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          return Future.error('Location permissions are denied.');
        }
      }

      // Mendapatkan lokasi saat ini
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      return Future.error('Error getting location: $e');
    }
  }

  Future<List<int>> compressImage(Uint8List bytes) async {
    int imageLength = bytes.length;
    if (imageLength < 1000000) return bytes;

    final img.Image image = img.decodeImage(bytes)!;
    int compressQuality = 100;
    int length = imageLength;
    List<int> newByte = [];

    do {
      compressQuality -= 10;

      newByte = img.encodeJpg(
        image,
        quality: compressQuality,
      );

      length = newByte.length;
    } while (length > 1000000);

    return newByte;
  }

  Future<bool> create(
      {required String description, required bool location}) async {
    CreateStoryUsecase create = ref.read(createStoryUsecaseProvider);

    // final position = await getCurrentLocation();
    final bytes = await photo!.readAsBytes();
    final image = await compressImage(bytes);
    var result = await create(
      StoryParams(
        description: description,
        bytes: image,
        fileName: photo!.name,
        lat: location == false ? 0.0 : markers.last.position.latitude,
        lon: location == false ? 0.0 : markers.last.position.longitude,
      ),
    );
    if (result.isNotEmpty) {
      _photo = null;
      return true;
    } else {
      return false;
    }
  }

  Future<DetailStoryModel> getDetail({required String id}) async {
    GetDetailStoryUsecase detail = ref.read(getDetailStoryUsecaseProvider);
    var result = await detail(id);
    if (result.error == false) {
      return result;
    } else {
      return Future.error('Error get Detail');
    }
  }

  Future<void> onLongPressGoogleMap(LatLng latLng) async {
    final info =
        await geo.placemarkFromCoordinates(latLng.latitude, latLng.longitude);

    final place = info[0];
    final street = place.street!;
    final address =
        '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

    placemark = place;

    defineMarker(latLng, street, address);

    mapController.animateCamera(
      CameraUpdate.newLatLng(latLng),
    );
  }

  void onMyLocationButtonPress() async {
    final position = await getCurrentLocation();

    final latLng = LatLng(position.latitude, position.longitude);

    final info =
        await geo.placemarkFromCoordinates(latLng.latitude, latLng.longitude);

    final place = info[0];
    final street = place.street!;
    final address =
        '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

    placemark = place;

    defineMarker(latLng, street, address);

    mapController.animateCamera(
      CameraUpdate.newLatLng(latLng),
    );
  }

  void defineMarker(LatLng latLng, String street, String address) {
    final marker = Marker(
      markerId: const MarkerId("source"),
      position: latLng,
      infoWindow: InfoWindow(
        title: street,
        snippet: address,
      ),
    );

    markers.clear();
    markers.add(marker);
  }

  // final allStoryProvider = AsyncNotifierProvider<DataStory, AllStoryModel>(
  //   () => DataStory(),
  // );
}
