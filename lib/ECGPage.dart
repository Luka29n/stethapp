import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'dart:convert';


class ECGPage extends StatefulWidget {
  const ECGPage({ super.key });

  @override
  State<ECGPage> createState() => _ECGState();
}

class _ECGState extends State<ECGPage> {
  int _ECG = 0;
  bool _isConnected = false;
  BluetoothDevice? _connectedDevice;
  BluetoothCharacteristic? _ECGCharacteristic;
  BluetoothCharacteristic? _commandCharacteristic;

  // Définition des UUID correspondant à l'Arduino
  final String SERVICE_UUID = "19b10000-e8f2-537e-4f6c-d104768a1214";
  final String COMMAND_CHARACTERISTIC_UUID = "19b10001-e8f2-537e-4f6c-d104768a1214";
  final String ECG_CHARACTERISTIC_UUID = "19b10003-e8f2-537e-4f6c-d104768a1214";


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
      _startListeningToECG();
    }
  }

  void _startListeningToECG() async {
  print('Starting to listen for ECG');
    List<BluetoothService> services = await _connectedDevice!.discoverServices();
    print('Discovered ${services.length} services');
    
    for (BluetoothService service in services) {
      if (service.uuid.toString() == SERVICE_UUID) {
        print('Found matching service: ${service.uuid}');
        
        for (BluetoothCharacteristic characteristic in service.characteristics) {
          if (characteristic.uuid.toString() == ECG_CHARACTERISTIC_UUID) {
            _ECGCharacteristic = characteristic;
            await _ECGCharacteristic!.setNotifyValue(true);
            _ECGCharacteristic!.value.listen((value) {
              if (value.isNotEmpty) {
                String rawString = String.fromCharCodes(value);
                print('Raw value: $rawString');
                
                if (rawString.startsWith('e:')) {
                  // Enlever le préfixe 'b:' et convertir en nombre
                  String ECGValue = rawString.substring(2);
                  setState(() {
                    _ECG = int.tryParse(ECGValue) ?? 0;
                  });
                }
                
                print('Parsed ECG: $_ECG');
              }
            });
            print('Listening to ECG characteristic');
          }
          
          if (characteristic.uuid.toString() == COMMAND_CHARACTERISTIC_UUID) {
            _commandCharacteristic = characteristic;
            // Envoyer la commande pour démarrer les mesures ECG
            await _commandCharacteristic!.write(utf8.encode('ecg'));
            print('Sent ECG command');
          }
        }
        break;
      }
    }
    
    if (_ECGCharacteristic == null) {
      print('Failed to find the ECG characteristic');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Électrocardiogramme", style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.grey.shade900)),
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