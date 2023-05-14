import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'AVIATION_STACK_KEY', obfuscate: true)
  static final aviationStackApiKey = _Env.aviationStackApiKey;
}
