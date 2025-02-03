import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'dart:convert';

class DataLog extends StatefulWidget {
  const DataLog({super.key});

  @override
  State<DataLog> createState() => _ECGState();
}

class _ECGState extends State<DataLog> {
  int _ECG = 0;
  bool _isConnected = false;
  BluetoothDevice? _connectedDevice;
  BluetoothCharacteristic? _ECGCharacteristic;
  BluetoothCharacteristic? _commandCharacteristic;

  // Définition des UUID correspondant à l'Arduino
  final String SERVICE_UUID = "19b10000-e8f2-537e-4f6c-d104768a1214";
  final String COMMAND_CHARACTERISTIC_UUID = "19b10001-e8f2-537e-4f6c-d104768a1214";
  final String ECG_CHARACTERISTIC_UUID = "19b10003-e8f2-537e-4f6c-d104768a1214";

  List<LiveData> _chartData = [];
  late ChartSeriesController _chartSeriesController;

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
    List<BluetoothService> services = await _connectedDevice!.discoverServices();
    for (BluetoothService service in services) {
      if (service.uuid.toString() == SERVICE_UUID) {
        for (BluetoothCharacteristic characteristic in service.characteristics) {
          if (characteristic.uuid.toString() == ECG_CHARACTERISTIC_UUID) {
            _ECGCharacteristic = characteristic;
            await _ECGCharacteristic!.setNotifyValue(true);
            _ECGCharacteristic!.value.listen((value) {
              if (value.isNotEmpty) {
                String rawString = String.fromCharCodes(value);
                if (rawString.startsWith('e:')) {
                  String ECGValue = rawString.substring(2);
                  int parsedValue = int.tryParse(ECGValue) ?? 0;
                  setState(() {
                    _ECG = parsedValue;
                  });
                  _updateChart(parsedValue.toDouble());
                }
              }
            });
          }

          if (characteristic.uuid.toString() == COMMAND_CHARACTERISTIC_UUID) {
            _commandCharacteristic = characteristic;
            await _commandCharacteristic!.write(utf8.encode('ecg'));
          }
        }
        break;
      }
    }
  }

  void _updateChart(double newValue) {
    setState(() {
      _chartData.add(LiveData(_chartData.length, newValue));
      if (_chartData.length > 50) {
        _chartData.removeAt(0); // Limite à 50 points
      }
      _chartSeriesController.updateDataSource(
        addedDataIndex: _chartData.length - 1,
        removedDataIndex: 0,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Électrocardiogramme",
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.grey.shade900),
        ),
      ),
      body: _isConnected
          ? Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80.0),
                    child: Image(
                      image: const AssetImage("assets/pictures/ecg.png"),
                      width: MediaQuery.of(context).size.width * 0.8,
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: SfCartesianChart(
                    primaryXAxis: NumericAxis(
                      title: AxisTitle(text: 'Temps'),
                    ),
                    primaryYAxis: NumericAxis(
                      title: AxisTitle(text: 'Valeur ECG'),
                    ),
                    series: <LineSeries<LiveData, int>>[
                      LineSeries<LiveData, int>(
                        onRendererCreated: (ChartSeriesController controller) {
                          _chartSeriesController = controller;
                        },
                        dataSource: _chartData,
                        xValueMapper: (LiveData data, _) => data.time,
                        yValueMapper: (LiveData data, _) => data.value,
                        color: Colors.red,
                      ),
                    ],
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
                    color: Colors.grey),
              ),
            ),
    );
  }
}

class LiveData {
  LiveData(this.time, this.value);
  final int time;
  final double value;
}
