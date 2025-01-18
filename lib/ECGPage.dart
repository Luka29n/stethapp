import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:google_fonts/google_fonts.dart';


int ecg = 0;

class ECGPage extends StatefulWidget {
  const ECGPage({ super.key });

  @override
  State<ECGPage> createState() => _ECGState();
}

class _ECGState extends State<ECGPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Électrocardiogramme", style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.grey.shade900)),
      ),
      body: 
      Column(
        children: [
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 80.0, right: 80.0, top: 0),
                  child: Image(
                    image: const AssetImage("assets/pictures/ecg.png"),
                    width: MediaQuery.of(context).size.width * 0.8, // 80% of screen width
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 6,
            child: Center(
              child: Container(
                child: const SfCartesianChart()
              ),
            ),
          ),
        ],
      )
    );
  }
}