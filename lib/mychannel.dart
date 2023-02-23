import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:developer' as developer;


void main() =>
    runApp(const MaterialApp(title: 'battery channel', home: GetBattery()));

class GetBattery extends StatefulWidget {
  const GetBattery({super.key});

  @override
  createState() => GetBatteryState();
}

class GetBatteryState extends State<GetBattery> {
  static const platform = MethodChannel('flutter.dev/channel');
  String _batteryLevel = '电量读取中...';

  Future<void> _getBatteryLevel() async {
    String battery;

    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      battery = '当前电量： $result%';
    } on PlatformException catch (e) {
      battery = '电量获取失败：${e.message}';
    }
    setState(() {
      _batteryLevel = battery;
    });
  }

  Future<void> _showToast(String msg) async {
    try {
      final int result = await platform.invokeMethod('showToast', {'msg': msg});
    } on PlatformException catch (e) {
      developer.log('PlatformException : ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('method channel')),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
              onPressed: _getBatteryLevel, child: Text('获取电量 ：$_batteryLevel')),
          const SizedBox(height: 10),
          ElevatedButton(
              onPressed: () {
                _showToast('flutter plugin toast');
              },
              child: const Text('showToast')),
        ])));
  }
}
