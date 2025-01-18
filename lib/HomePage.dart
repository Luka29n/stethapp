import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'settings.dart';
import 'bluetoothPage.dart';
import 'DataLog.dart';
import 'BPM.dart';
import 'ECGPage.dart';
import 'o2Page.dart';

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
                          color: const Color.fromARGB(162, 255, 0, 0),
                        ),
                        child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 20,right: 20),
                                  child: Image(image: AssetImage("assets/pictures/hearth.png")),
                                ),
                                Text("BPM",
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
                            color: const Color.fromARGB(255, 0, 0, 0),
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
                                MaterialPageRoute(builder: (context) => const O2page()),
                              );
                            },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                color: const Color.fromARGB(255, 0, 0, 0),
                                ),
                                child: Center(
                                  child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                              Icon(Icons.water_drop,color: Color.fromARGB(162, 255, 0, 0),size: 80,),
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
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                color: const Color.fromARGB(162, 255, 0, 0),
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
                  color: const Color.fromARGB(255, 0, 0, 0),
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
                          color: const Color.fromARGB(255, 0, 0, 0),
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
                          color: const Color.fromARGB(162, 255, 0, 0),
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