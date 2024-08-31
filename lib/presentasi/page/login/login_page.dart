import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:story_app/presentasi/provider/auth/data_user_provider.dart';
import 'package:story_app/presentasi/router/router_provider.dart';
import 'package:story_app/presentasi/widget/text_form_field_password_widget.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  bool isLoading = false;
  bool iconButton = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ref.listen(
      dataUserProvider,
      (previous, next) {
        if (next is AsyncData) {
          if (next.value != "") {
            ref.read(routerProvider).goNamed("Home");
          }
        }
      },
    );

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.05,
          vertical: height * 0.01,
        ),
        children: [
          SizedBox(height: height * 0.05),
          const Text(
            "Login",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text("Login to Continue Using the App"),
          SizedBox(height: height * 0.02),
          const Text(
            "Email",
            style: TextStyle(fontSize: 16),
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: "Enter Your Email",
              fillColor: Colors.grey[100],
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            controller: emailController,
          ),
          SizedBox(height: height * 0.02),
          TextFieldPasswordWidget(
            hinttext: "Enter Password",
            controller: passwordController,
            title: "Password",
            iconButton: true,
          ),
          SizedBox(height: height * 0.05),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[400],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: isLoading ? null : login,
            child: isLoading
                ? const CircularProgressIndicator()
                : const Text("Login"),
          ),
          SizedBox(height: height * 0.02),
          ElevatedButton(
            onPressed: () {
              ref.read(routerProvider).goNamed("Register");
            },
            child: const Text("Registrasi"),
          )
        ],
      ),
    );
  }

  void login() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      ref.read(dataUserProvider.notifier).loginUser(
            email: emailController.text,
            password: passwordController.text,
          );
      setState(() {
        isLoading = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Mohon Masukkan Data dengan Benar dan Lengkap"),
        ),
      );
    }
  }
}
