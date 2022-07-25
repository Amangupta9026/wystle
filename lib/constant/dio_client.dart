
import 'package:dio/dio.dart';

Dio dio = Dio(BaseOptions(
  connectTimeout: 500000,
  receiveTimeout: 500000,
));
