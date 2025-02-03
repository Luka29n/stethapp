import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'settings.dart';
import 'bluetoothPage.dart';
import 'DataLog.dart';
import 'BPM.dart';
import 'ECGPage.dart';
import 'O2Page.dart';
import 'Login_page.dart';
import 'auth_page.dart';

Color FistColor = Color.fromARGB(209, 255, 0, 0);
Color SecondColor = Color.fromARGB(255, 0, 0, 0);

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 30, 3, 3),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const BPM()),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: FistColor,
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(  // Ajout de Expanded ici
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 20),
                                  child: Image(
                                    image: AssetImage("assets/pictures/hearth.png"),
                                    fit: BoxFit.contain,  // Ajout de BoxFit.contain
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 40),  // Ajout d'un padding en bas
                                child: Text(
                                  "BPM",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                    color: const Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(3, 30, 15, 3),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const ECGPage()),
                              );
                            },
                          child: Container(
                            decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: SecondColor
                          ),
                          
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 20,right: 20),
                                  child: Container(
                                    width: 200, // Largeur du conteneur
                                    height: 80, // Hauteur du conteneur
                                    child: Image(
                                      image: AssetImage("assets/pictures/ecg.png"),
                                      fit: BoxFit.contain,
                                      ),
                                    ),

                                ),
                                Text("ECG",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                        color: const Color.fromARGB(255, 255, 255, 255)))
                              ],
                            )),
                          ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Row(children: [
                          Expanded(
                            flex: 5,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(3, 3, 3, 3),
                              child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const O2Page()),
                              );
                            },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                color: SecondColor
                                ),
                                child: Center(
                                  child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                              Icon(Icons.water_drop,color: FistColor,size: 80,),
                              Text("O₂",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: const Color.fromARGB(255, 255, 255, 255)),
                                ),
                            ],
                          ),
                          ),
                              ),
                              ),
                            ),
                            ),
                          Expanded(
                            flex: 5,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(3, 3, 15, 3),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => AuthPage()),
                                  );
                                },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                color:  FistColor,
                                ),
                                child: StreamBuilder<User?>(
                                  stream: FirebaseAuth.instance.authStateChanges(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return const Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Chargement...",
                                              style: TextStyle(color: Colors.white, fontSize: 10),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                    if (snapshot.hasData) {
                                      return Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.account_circle_rounded,
                                            color: Color.fromARGB(255, 255, 255, 255),
                                            size: 80,
                                          ),
                                          Text(
                                            "Account",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                              color: Color.fromARGB(255, 255, 255, 255),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                    else {
                                      return Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.account_circle_rounded,
                                          color: Color.fromARGB(255, 255, 255, 255),
                                          size: 80,
                                        ),
                                        Text(
                                          "login",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 23,
                                            color: Color.fromARGB(255, 255, 255, 255),
                                          ),
                                        ),
                                      ],
                                    );
                                    }

                                  },
                                )
                              ),
                              ),
                            ),
                            ),
                        ],),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 3, 15, 3),
              child: GestureDetector(
              onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SettingsPage()),
                        );
                      },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: SecondColor
                ),
                child: Center(
                  child: Text("SETTINGS",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: const Color.fromARGB(255, 255, 255, 255))),
                ),
              ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 3, 3, 15),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const BluetoothPairPage()),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: SecondColor
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.bluetooth,color: Colors.white,size: 80,),
                              Text("  Bluetooth\nConnection",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: const Color.fromARGB(255, 255, 255, 255)),
                                ),
                            ],
                          ),
                          ),
                      ),
                      ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(3, 3, 15, 15),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const DataLog()),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: FistColor,
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.document_scanner_outlined,color: Colors.white,size: 80,),
                              Text("Data\n  Log",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: const Color.fromARGB(255, 255, 255, 255)),
                                ),
                            ],
                          ),
                          ),
                      ),
                      ),
                    ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}