import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'dart:convert';

// Classe pour stocker les données BPM
class BPMData {
  final DateTime time;
  final int bpm;

  BPMData(this.time, this.bpm);
}

class BPM extends StatefulWidget {
  const BPM({super.key});

  @override
  State<BPM> createState() => _BPMState();
}

class _BPMState extends State<BPM> {
  bool _isConnected = false;
  int _bpm = 0;
  BluetoothDevice? _connectedDevice;
  BluetoothCharacteristic? _bpmCharacteristic;
  BluetoothCharacteristic? _commandCharacteristic;
  List<BPMData> _bpmHistory = [];
  final int maxDataPoints = 7; // Nombre maximum de points à afficher

  // Définition des UUID correspondant à l'Arduino
  final String SERVICE_UUID = "19b10000-e8f2-537e-4f6c-d104768a1214";
  final String COMMAND_CHARACTERISTIC_UUID = "19b10001-e8f2-537e-4f6c-d104768a1214";
  final String BPM_CHARACTERISTIC_UUID = "19b10002-e8f2-537e-4f6c-d104768a1214";

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

  void _updateBPMHistory(int bpm) {
    setState(() {
      _bpmHistory.add(BPMData(DateTime.now(), bpm));
      // Garder seulement les derniers points
      if (_bpmHistory.length > maxDataPoints) {
        _bpmHistory.removeAt(0);
      }
    });
  }

  void _startListeningToBPM() async {
    print('Starting to listen for BPM');
    List<BluetoothService> services = await _connectedDevice!.discoverServices();
    print('Discovered ${services.length} services');
    
    for (BluetoothService service in services) {
      if (service.uuid.toString() == SERVICE_UUID) {
        print('Found matching service: ${service.uuid}');
        
        for (BluetoothCharacteristic characteristic in service.characteristics) {
          if (characteristic.uuid.toString() == BPM_CHARACTERISTIC_UUID) {
            _bpmCharacteristic = characteristic;
            await _bpmCharacteristic!.setNotifyValue(true);
            _bpmCharacteristic!.value.listen((value) {
              if (value.isNotEmpty) {
                String rawString = String.fromCharCodes(value);
                print('Raw value: $rawString');
                
                if (rawString.startsWith('b:')) {
                  String bpmValue = rawString.substring(2);
                  final newBpm = int.tryParse(bpmValue) ?? 0;
                  setState(() {
                    _bpm = newBpm;
                  });
                  _updateBPMHistory(newBpm);
                }
                
                print('Parsed BPM: $_bpm');
              }
            });
            print('Listening to BPM characteristic');
          }
          
          if (characteristic.uuid.toString() == COMMAND_CHARACTERISTIC_UUID) {
            _commandCharacteristic = characteristic;
            await _commandCharacteristic!.write(utf8.encode('bpm'));
            print('Sent BPM command');
          }
        }
        break;
      }
    }
    
    if (_bpmCharacteristic == null) {
      print('Failed to find the BPM characteristic');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Fréquence cardiaque",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.grey.shade900
          )
        ),
      ),
      body: _isConnected
        ? Column(
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 80.0,
                        right: 80.0,
                        top: 0
                      ),
                      child: Image(
                        image: const AssetImage("assets/pictures/hearth.png"),
                        width: MediaQuery.of(context).size.width * 0.8,
                      ),
                    ),
                    Text(
                      "$_bpm battements/minutes",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.grey.shade900
                      )
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SfCartesianChart(
                    primaryXAxis: NumericAxis(
                      isVisible: false,
                    ),
                    primaryYAxis: NumericAxis(
                      minimum: 0,
                      maximum: 200,
                      interval: 20,
                      title: AxisTitle(text: 'BPM'),
                    ),
                    series: <CartesianSeries>[
                      ColumnSeries<BPMData, int>(
                        dataSource: _bpmHistory,
                        xValueMapper: (BPMData data, int index) => index, // Utilisation de l'index comme valeur X
                        yValueMapper: (BPMData data, _) => data.bpm,
                        color: Colors.red.shade400,
                        width: 0.8,
                        spacing: 0.2,
                      )

                    ],
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