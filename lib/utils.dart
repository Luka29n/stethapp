import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart';

Future<void> requestPermission({required Permission permission}) async {
  final status = await permission.status;
  if (status.isGranted){
    debugPrint("Permission already granted");
  }
  else if (status.isDenied){
    if (await permission.request().isGranted){
      debugPrint("Permission granted");
    }
    else{
      debugPrint("Permission denied");
    }
  }
}
