import 'dart:ui' as ui show SingletonFlutterWindow, PlatformDispatcher, window;

import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

/// A subset of `WidgetsFlutterBinding` specifically for [ServicesBinding].
/// This binding includes only the [SchedulerBinding] and [ServicesBinding]
/// and can be used to support accessing data from the underlying platform
/// before without initializing the `WidgetsBinding.instance`
/// within the root `Zone`.
class FlutterServicesBinding extends _StandaloneBindingBase
    with SchedulerBinding, ServicesBinding {
  FlutterServicesBinding._();

  /// Returns an instance of the [FlutterServicesBinding], creating and
  /// initializing it if necessary.
  ///
  /// You only need to call this method if you need the binding to be
  /// initialized before calling `runApp`.
  factory FlutterServicesBinding.ensureInitialized() {
    return _instance ??= FlutterServicesBinding._();
  }

  static FlutterServicesBinding? _instance;
}

abstract class _StandaloneBindingBase implements BindingBase {
  _StandaloneBindingBase() {
    window.onReportTimings = null;
    initInstances();
    window.onReportTimings = null;
  }

  @override
  ui.SingletonFlutterWindow get window => ui.window;

  @override
  ui.PlatformDispatcher get platformDispatcher {
    return ui.PlatformDispatcher.instance;
  }

  @override
  @protected
  @mustCallSuper
  void initInstances() {}

  @override
  @protected
  @mustCallSuper
  void initServiceExtensions() {}

  @override
  @protected
  bool get locked => false;

  @override
  @protected
  Future<void> lockEvents(Future<void> Function() callback) async {}

  @override
  @protected
  @mustCallSuper
  void unlocked() {}

  @override
  Future<void> reassembleApplication() async {}

  @override
  @mustCallSuper
  @protected
  Future<void> performReassemble() async {}

  @override
  @protected
  void registerSignalServiceExtension({
    required String name,
    required AsyncCallback callback,
  }) {}

  @override
  @protected
  void registerBoolServiceExtension({
    required String name,
    required AsyncValueGetter<bool> getter,
    required AsyncValueSetter<bool> setter,
  }) {}

  @override
  @protected
  void registerNumericServiceExtension({
    required String name,
    required AsyncValueGetter<double> getter,
    required AsyncValueSetter<double> setter,
  }) {}

  @override
  @protected
  void postEvent(String eventKind, Map<String, dynamic> eventData) {}

  @override
  @protected
  void registerStringServiceExtension({
    required String name,
    required AsyncValueGetter<String> getter,
    required AsyncValueSetter<String> setter,
  }) {}

  @override
  @protected
  void registerServiceExtension({
    required String name,
    required ServiceExtensionCallback callback,
  }) {}

  @override
  String toString() => '<${objectRuntimeType(this, 'BindingBase')}>';
}
