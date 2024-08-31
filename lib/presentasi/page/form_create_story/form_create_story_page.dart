import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_app/presentasi/provider/story/story_data_provider.dart';
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
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            ref.read(routerProvider).goNamed("Home");
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text(
          "Create Story",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
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
                    File(ref.watch(dataStoryProvider.notifier).photo!.path),
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
                  await ref.read(dataStoryProvider.notifier).onCameraView();
                  setState(() {});
                },
                child: const Text("Camera"),
              ),
              SizedBox(width: width * 0.05),
              ElevatedButton(
                onPressed: () async {
                  await ref.read(dataStoryProvider.notifier).onGalleriView();
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
        ],
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
}
