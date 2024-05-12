import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import '../env/env.dart';

class ParseInitializer {

  static Future<void> initialize() async {
    final String keyApplicationId = Env.keyApplicationId;
    final String keyClientKey = Env.keyClientKey;
    const String keyParseServerUrl = 'https://parseapi.back4app.com';

    await Parse().initialize(keyApplicationId, keyParseServerUrl,
        clientKey: keyClientKey, debug: true);
  }
  
}
