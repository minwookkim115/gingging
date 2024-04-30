import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  List<ScanResult> devicesList = [];

  @override
  void initState() {
    super.initState();
    startScan();
  }

  void startScan() async {
    await FlutterBluePlus.adapterState.listen((state){
      if (state == BluetoothAdapterState.on) {
        // 블루투스가 켜져 있으면 스캔 시작
        FlutterBluePlus.startScan(timeout: const Duration(seconds: 10));
      } else {
        print("블루투스가 꺼져 있습니다.");
      }
    });
    // 스캔 결과 처리
    FlutterBluePlus.scanResults.listen((results) {
      setState(() {
        devicesList = results;
        print('결과 출력 $devicesList');
      });
      for (ScanResult result in results) {
        print('${result.device.advName} found! rssi: ${result.rssi}');
      }
    });

    // 스캔 종료
    Future.delayed(const Duration(seconds: 10))
        .then((_) => FlutterBluePlus.stopScan());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('스캔스크린'),
    );
  }
}