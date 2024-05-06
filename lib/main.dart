import 'package:flutter/material.dart';

import 'app.dart';
import 'services/api/api_service.dart';
import 'services/service_locator.dart';

/// Purpose : This is the main method of application. it will be called first.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  locator<ApiService>();
  runApp(const App());
}

