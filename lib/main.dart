import 'package:starfish/http/dio_instance.dart';
import 'package:starfish/util/flogger_util.dart';

void main() {
  // 初始化日志
  FLogger log = FLogger.instance().init();
  DioInstance.instance().init(baseUrl: 'http://127.0.0.1:8080');
  log.info("dio init success");
  // runApp(const MyApp());
}
