import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_app/presentasi/provider/auth/data_user_provider.dart';
import 'package:story_app/presentasi/router/router_provider.dart';
import 'package:story_app/presentasi/widget/text_form_field_password_widget.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  bool isLoading = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            ref.read(routerProvider).goNamed("Login");
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text("Register"),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        children: [
          SizedBox(
            height: height * 0.07,
          ),
          const Text(
            "Name",
            style: TextStyle(fontSize: 16),
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: "Enter Your Name",
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            controller: nameController,
          ),
          SizedBox(height: height * 0.01),
          const Text(
            "Email",
            style: TextStyle(fontSize: 16),
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: "Enter your Email",
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            controller: emailController,
          ),
          SizedBox(height: height * 0.01),
          TextFieldPasswordWidget(
            hinttext: "Enter Password",
            controller: passwordController,
            title: "Password",
            iconButton: true,
          ),
          SizedBox(height: height * 0.1),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: height * 0.01),
              backgroundColor: Colors.blue[400],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: isLoading ? null : registrasi,
            child: isLoading
                ? const CircularProgressIndicator()
                : const Text(
                    "Registrasi",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
          ),
          SizedBox(height: height * 0.1),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Sudah Memiliki Akun"),
              TextButton(
                onPressed: () {
                  ref.read(routerProvider).goNamed("Login");
                },
                child: const Text(
                  "Sign Up",
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void registrasi() async {
    if (nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      bool registrasi = await ref.read(dataUserProvider.notifier).registrasi(
          email: emailController.text,
          password: passwordController.text,
          name: nameController.text);
      setState(() {
        isLoading = false;
      });
      if (registrasi) {
        ref
            .read(routerProvider)
            .pushReplacementNamed("Login"); // Kembali ke halaman sebelumnya
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to create story')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Mohon Masukkan Data dengan Benar dan Lengkap"),
        ),
      );
    }
  }
}
