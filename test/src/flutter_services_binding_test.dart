// ignore_for_file: prefer_const_constructors
import 'dart:ui';

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

    test('.platformDispatcher returns an instance', () {
      expect(
        FlutterServicesBinding.ensureInitialized().platformDispatcher,
        equals(PlatformDispatcher.instance),
      );
    });

    test('.initServiceExtensions does nothing', () {
      FlutterServicesBinding.ensureInitialized().initServiceExtensions();
    });

    test('.lockEvents completes', () {
      expect(
        // ignore: invalid_use_of_protected_member
        FlutterServicesBinding.ensureInitialized().lockEvents(() async {}),
        completes,
      );
    });

    test('.locked returns false', () {
      expect(
        // ignore: invalid_use_of_protected_member
        FlutterServicesBinding.ensureInitialized().locked,
        isFalse,
      );
    });

    test('.unlocked does nothing', () {
      FlutterServicesBinding.ensureInitialized().unlocked();
    });

    test('.reassembleApplication completes', () {
      expect(
        FlutterServicesBinding.ensureInitialized().reassembleApplication(),
        completes,
      );
    });

    test('.performReassemble completes', () {
      expect(
        // ignore: invalid_use_of_protected_member
        FlutterServicesBinding.ensureInitialized().performReassemble(),
        completes,
      );
    });

    test('.registerSignalServiceExtension does nothing', () {
      // ignore: invalid_use_of_protected_member
      FlutterServicesBinding.ensureInitialized().registerSignalServiceExtension(
        name: 'name',
        callback: () async {},
      );
    });

    test('.registerBoolServiceExtension does nothing', () {
      // ignore: invalid_use_of_protected_member
      FlutterServicesBinding.ensureInitialized().registerBoolServiceExtension(
        name: 'name',
        getter: () async => true,
        setter: (_) async {},
      );
    });

    test('.registerNumericServiceExtension does nothing', () {
      FlutterServicesBinding.ensureInitialized()
          // ignore: invalid_use_of_protected_member
          .registerNumericServiceExtension(
        name: 'name',
        getter: () async => 0,
        setter: (_) async {},
      );
    });

    test('.registerStringServiceExtension does nothing', () {
      FlutterServicesBinding.ensureInitialized()
          // ignore: invalid_use_of_protected_member
          .registerStringServiceExtension(
        name: 'name',
        getter: () async => '',
        setter: (_) async {},
      );
    });

    test('.registerServiceExtension does nothing', () {
      FlutterServicesBinding.ensureInitialized()
          // ignore: invalid_use_of_protected_member
          .registerServiceExtension(
        name: 'name',
        callback: (_) async => <String, dynamic>{},
      );
    });

    test('.postEvent does nothing', () {
      // ignore: invalid_use_of_protected_member
      FlutterServicesBinding.ensureInitialized().postEvent(
        'eventKind',
        <String, dynamic>{},
      );
    });

    test('.toString returns correct value', () {
      // ignore: invalid_use_of_protected_member
      expect(
        FlutterServicesBinding.ensureInitialized().toString(),
        equals('<FlutterServicesBinding>'),
      );
    });
  });
}
