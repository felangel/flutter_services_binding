# flutter_services_binding

[![coverage][coverage_badge]][ci_link]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

A subset of `WidgetsFlutterBinding` specifically for initializing the `ServicesBinding`.

When executing `runApp` within a custom `Zone` with `zoneValues` derived from the underlying platform we rely on `WidgetsFlutterBinding.ensureInitialized()`:

```dart
final token = Object();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final value = await _getPlatformValue();
  runZoned(
    () => runApp(MyApp()),
    zoneValues: {token: value},
  );
}
```

This appears to work as expected, however, because `WidgetsFlutterBinding` also initializes other bindings like `GestureBinding` the `zoneValue` is not accessible within `onPressed` callbacks:

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(Zone.current[token]); // OK
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              print(Zone.current[token]); // NULL
            },
            child: Text('Click Me'),
          ),
        ),
      ),
    );
  }
}
```

`FlutterServicesBinding` provides an API to initialize the `ServicesBinding` and `SchedulerBinding` independently of the remaining bindings in order to support accessing data from the underlying platform before `runApp` but without initializing the `WidgetsBinding` instance within the root `Zone`.

```dart
final token = Object();
void main() async {
  FlutterServicesBinding.ensureInitialized();
  final value = await _getPlatformValue();
  runZoned(
    () => runApp(MyApp()),
    zoneValues: {token: value},
  );
}
```

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(Zone.current[token]); // OK
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              print(Zone.current[token]); // OK
            },
            child: Text('Click Me'),
          ),
        ),
      ),
    );
  }
}
```

[ci_link]: https://github.com/felangel/flutter_services_binding/actions
[coverage_badge]: https://raw.githubusercontent.com/felangel/flutter_services_binding/main/coverage_badge.svg
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
