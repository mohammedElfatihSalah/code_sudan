import 'package:flutter/material.dart';
import 'my_app.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

const String KEY_APPLICATOIN_ID = 'n9cpvgJTMx3To4UEaOEhpD4mRNZ1w5WxYhKcdXAX';
const String KEY_PARSE_SDK_CLIENT_KEY =
    'trYcs8hw15Vi1OJUkghWljIyTs6KSIA0J2AjDpA5';
const String KEY_PARSE_SERVER_URL = 'https://parseapi.back4app.com';
const String KEY_PARSE_MASTER_KEY = 'LUjBLvJz1nBoiT12bNCzj1rLQH2IO76epnJrJ1oa';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String appDocPath = appDocDir.path;
  print(appDocPath);
  await Parse().initialize(
    KEY_APPLICATOIN_ID, KEY_PARSE_SERVER_URL,
    masterKey: KEY_PARSE_MASTER_KEY, // Required for Back4App and others
    clientKey: KEY_PARSE_SDK_CLIENT_KEY, // Required for some setups
    debug: true, // When enabled, prints logs to console
    autoSendSessionId: true, // Required for authentication and ACL
    coreStore: await CoreStoreSembastImp.getInstance(appDocPath + '/data'),
  );
  runApp(MyApp());
}
