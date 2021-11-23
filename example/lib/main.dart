import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_services_binding/flutter_services_binding.dart';
import 'package:path_provider/path_provider.dart';

final token = Object();

Future<void> main() async {
  FlutterServicesBinding.ensureInitialized();
  final tempDirectory = await getTemporaryDirectory();
  runZoned(() => runApp(const MyApp()), zoneValues: {token: tempDirectory});
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(child: Text('ZoneValue: ${Zone.current[token]}')),
        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton(
              onPressed: () {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(
                        'ZoneValue: ${Zone.current[token]}',
                      ),
                    ),
                  );
              },
            );
          },
        ),
      ),
    );
  }
}
