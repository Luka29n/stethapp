import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';



class O2Page extends StatefulWidget {
  const O2Page({ super.key });

  @override
  State<O2Page> createState() => _O2State();
}

class _O2State extends State<O2Page> {
  
  bool _isConnected = false;
  BluetoothDevice? _connectedDevice;
  BluetoothCharacteristic? _bpmCharacteristic;
  BluetoothCharacteristic? _commandCharacteristic;

  // Définition des UUID correspondant à l'Arduino
  final String SERVICE_UUID = "19b10000-e8f2-537e-4f6c-d104768a1214";
  final String COMMAND_CHARACTERISTIC_UUID = "19b10001-e8f2-537e-4f6c-d104768a1214";
  final String BPM_CHARACTERISTIC_UUID = "19b10003-e8f2-537e-4f6c-d104768a1214";


  @override

  void initState() {
    super.initState();
    _checkConnectionStatus();
  }

  void _checkConnectionStatus() async {
    List<BluetoothDevice> connectedDevices = FlutterBluePlus.connectedDevices;
    if (connectedDevices.isNotEmpty) {
      setState(() {
        _isConnected = true;
        _connectedDevice = connectedDevices.first;
      });
      _startListeningToBPM();
    }
  }

  void _startListeningToBPM() async {

  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Blood Oxygen", style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.grey.shade900)),
      ),
      body: _isConnected
      ? Column(
        children: [
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 80.0, right: 80.0, top: 0),
                  child: Image(
                    image: const AssetImage("assets/pictures/O2.png"),
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
      : Center(
            child: Text(
              "Aucun appareil connecté",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.grey
              ),
            ),
          ),
    );
  }
}