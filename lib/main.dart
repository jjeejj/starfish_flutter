import 'package:starfish/http/dio_instance.dart';

void main() {
  DioInstance.instance().init(baseUrl: 'http://127.0.0.1:8080');
  // runApp(const MyApp());
}
