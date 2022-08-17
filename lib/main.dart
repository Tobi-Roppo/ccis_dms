import 'package:flutter/material.dart';
import 'package:ccis_dms/environment.dart';
import 'package:ccis_dms/root_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Environment.init(
    apiBaseUrl: 'https://example.com',
  );

  runApp(const RootApp());
}
