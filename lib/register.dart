import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stethoscope/login_page.dart';
import 'HomePage.dart';

class register extends StatelessWidget {
  register({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();

  void signUserUp(BuildContext context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Text(
                "Let's create your account",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.grey.shade900,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Icon(Icons.lock, size: 100),
              const SizedBox(height: 20),
              Text("*required information", style: GoogleFonts.poppins(fontSize: 15)),
              const SizedBox(height: 20),
              _buildTextField(emailController, "Enter your Email*", false),
              const SizedBox(height: 10),
              _buildTextField(passwordController, "Create a Password*", true),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: _buildTextField(firstNameController, "First Name*", false)),
                  const SizedBox(width: 10),
                  Expanded(child: _buildTextField(secondNameController, "Second Name*", false)),
                ],
              ),
              const SizedBox(height: 25),
              GestureDetector(
                onTap: () => signUserUp(context),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey.shade400)),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text('or continue with'),
                  ),
                  Expanded(child: Divider(color: Colors.grey.shade400)),
                ],
              ),
              const SizedBox(height: 20),
              Image.asset("assets/pictures/google.png", height: 40),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already a member? ", style: GoogleFonts.poppins(fontSize: 12)),
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Login())),
                    child: Text("Sign in", style: GoogleFonts.poppins(fontSize: 12, color: Colors.blue)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, bool obscureText) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
        labelStyle: TextStyle(color: Colors.black),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2)),
      ),
    );
  }
}
