import 'package:firebase_core/firebase_core.dart';
import 'package:focus_time/config/api/sqflite_api.dart';
import 'package:focus_time/firebase_options.dart';
import 'package:focus_time/injector.dart';

class AppConfig {
  static Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await MyInjector.init();
    await MySqfliteAPI.initLocalDatabase();
    await MySqfliteAPI.getLogedUser();
  }
}
