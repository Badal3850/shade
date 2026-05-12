import 'package:flutter/material.dart';

/// Breakpoint: narrow = phone portrait, wide = tablet / landscape phone.
const double _kWideBreakpoint = 600.0;

class AppLayout {
  AppLayout._();

  static bool isWide(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= _kWideBreakpoint;

  /// Returns [wide] on wide screens, [narrow] on narrow screens.
  static T when<T>(BuildContext context, {required T narrow, required T wide}) =>
      isWide(context) ? wide : narrow;
}
