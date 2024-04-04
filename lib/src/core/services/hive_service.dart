// Package imports:

// Package imports:
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

// Project imports:
import '../utils/app_logger.dart';
import '../utils/constant.dart';
import 'service_interface.dart';

class HiveService implements ServiceInterface {
  @override
  String get name => "Hive Service";

  late final Box<Map<dynamic, dynamic>> box;

  @override
  Future<void> initializeService() async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    await Hive.initFlutter(directory.path);
    box = await Hive.openBox<Map<dynamic, dynamic>>(kDBName);
    AppLogger.logDebug('$name Success initialization');
  }

  // singleton
  HiveService.init();
  static HiveService? _instance;
  factory HiveService() => _instance ??= HiveService.init();
}
