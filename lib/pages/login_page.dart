import 'package:flutter/material.dart';
import 'package:zego_uikit_app/cache/shared_prefs.dart';
import 'package:zego_uikit_app/pages/home_page.dart';
import 'package:zego_uikit_app/services/call_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final idController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  Future<void> onLogin() async {
    if (!formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    await SharedPrefs.setString("username", usernameController.text);
    await SharedPrefs.setString("id", idController.text);

    await CallServices().onUserLogin(
      idController.text,
      usernameController.text,
    );

    setState(() => isLoading = false);

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const HomePage()),
      (route) => false,
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(labelText: "Username"),
                validator: (v) =>
                    v == null || v.isEmpty ? "Enter username" : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: idController,
                decoration: const InputDecoration(labelText: "User ID"),
                validator: (v) =>
                    v == null || v.isEmpty ? "Enter ID" : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isLoading ? null : onLogin,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}