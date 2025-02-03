import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothPairPage extends StatefulWidget {
  const BluetoothPairPage({super.key});

  @override
  _BluetoothPairPageState createState() => _BluetoothPairPageState();
}

class _BluetoothPairPageState extends State<BluetoothPairPage> {
  List<ScanResult> _scanResults = [];
  bool _isScanning = false;
  StreamSubscription<List<ScanResult>>? _scanSubscription;

  @override
  void initState() {
    super.initState();
    _startScan(); // Start scanning when the page is initialized
  }

  @override
  void dispose() {
    _scanSubscription?.cancel();
    super.dispose();
  }

  void _startScan() async {
    if (_isScanning) return; // Prevent multiple simultaneous scans

    setState(() {
      _isScanning = true;
      _scanResults.clear();
    });

    try {
      // Cancel any existing subscription
      await _scanSubscription?.cancel();

      // Start the scan
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 1));

      // Listen for scan results
      _scanSubscription = FlutterBluePlus.scanResults.listen((results) {
        setState(() {
          _scanResults = results;
        });
      });

      // Wait for the scan to complete
      await FlutterBluePlus.isScanning.where((val) => val == false).first;
    } catch (e) {
      print('Error during scan: $e');
    } finally {
      setState(() {
        _isScanning = false;
      });
    }
  }

  void _connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Connected to ${device.name}")),
      );
    } catch (e) {
      print('Error connecting to device: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to connect to ${device.name}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bluetooth Pairing"),
      ),
      body: Column(
        children: [
          // Section for named devices
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Named Devices",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            child: _isScanning
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Builder(
                    builder: (context) {
                      final namedDevices = _scanResults
                          .where((result) => result.device.name.isNotEmpty)
                          .toList();

                      if (namedDevices.isEmpty) {
                        return const Center(
                          child: Text(
                            "No named devices found",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: namedDevices.length,
                        itemBuilder: (context, index) {
                          final device = namedDevices[index].device;
                          return ListTile(
                            title: Text(device.name),
                            subtitle: Text(device.id.id),
                            trailing: ElevatedButton(
                              child: const Text("Connect"),
                              onPressed: () => _connectToDevice(device),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
          SizedBox(height: 80,),
          // Section for unnamed devices
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Text(
              "Other Devices",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: _isScanning
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Builder(
                    builder: (context) {
                      final noNameDevices = _scanResults
                          .where((result) => result.device.name.isEmpty)
                          .toList();

                      if (noNameDevices.isEmpty) {
                        return const  Text(
                            "No unnamed devices found",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        
                      }

                      return ListView.builder(
                        itemCount: noNameDevices.length,
                        itemBuilder: (context, index) {
                          final device = noNameDevices[index].device;
                          return ListTile(
                            title: const Text("Unnamed Device"),
                            subtitle: Text(device.id.id),
                            trailing: ElevatedButton(
                              child: const Text("Connect"),
                              onPressed: () => _connectToDevice(device),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isScanning ? null : _startScan,
        child: Icon(_isScanning ? Icons.stop : Icons.refresh),
      ),
    );
  }
}
