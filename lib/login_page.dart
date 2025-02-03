import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stethoscope/register.dart';
import 'package:stethoscope/services/auth_services.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.03),

                Text(
                  "Login",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.07,
                    color: Colors.grey.shade900,
                  ),
                ),

                SizedBox(height: screenHeight * 0.04),

                Icon(
                  Icons.lock,
                  size: screenWidth * 0.25,
                ),

                SizedBox(height: screenHeight * 0.05),

                Text(
                  "Welcome Back",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.04,
                    color: const Color.fromARGB(255, 66, 63, 63),
                  ),
                ),

                SizedBox(height: screenHeight * 0.05),

                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    labelStyle: const TextStyle(color: Colors.black),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.03),

                TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    labelStyle: const TextStyle(color: Colors.black),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.02),

                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Forgot password?",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.035,
                      color: const Color.fromARGB(255, 66, 63, 63),
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.03),

                GestureDetector(
                  onTap: signUserIn,
                  child: Container(
                    padding: EdgeInsets.all(screenHeight * 0.02),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.045,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.05),

                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey, thickness: 0.5)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                      child: Text("or continue with"),
                    ),
                    Expanded(child: Divider(color: Colors.grey, thickness: 0.5)),
                  ],
                ),

                SizedBox(height: screenHeight * 0.05),

                GestureDetector(
                  onTap: () async {
                    AuthServices auth = AuthServices();
                    await auth.signInWithGoogle();
                  },
                  child: Image.asset(
                    "assets/pictures/google.png",
                    height: screenHeight * 0.05,
                  ),
                ),

                SizedBox(height: screenHeight * 0.05),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a member? ",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.035,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => register()),
                        );
                      },
                      child: Text(
                        "Register Now",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.035,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: screenHeight * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
