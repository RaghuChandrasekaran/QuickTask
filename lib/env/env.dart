import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  
  @EnviedField(varName: 'PARSE_APPLICATION_ID', obfuscate: true)
  static final String keyApplicationId = _Env.keyApplicationId;

   @EnviedField(varName: 'PARSE_CLIENT_KEY', obfuscate: true)
  static final String keyClientKey = _Env.keyClientKey;
}