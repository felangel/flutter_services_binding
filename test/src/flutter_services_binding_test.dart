// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_services_binding/flutter_services_binding.dart';
import 'package:flutter_test/flutter_test.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp();
  }
}

void main() {
  group('FlutterServicesBinding', () {
    test('.ensureInitialized creates an instance', () {
      expect(FlutterServicesBinding.ensureInitialized(), isNotNull);
    });

    test('.ensureInitialized returns existing instance', () {
      final instanceA = FlutterServicesBinding.ensureInitialized();
      final instanceB = FlutterServicesBinding.ensureInitialized();
      expect(instanceA, equals(instanceB));
    });
  });
}
