
import 'package:flutter/cupertino.dart';

class MyFlutterApp {
  MyFlutterApp._();
  static const _kFontFam = 'MyFlutterApp';
  static const _truck = 'MyCustomTruck';
  static const _navigate = 'MyCustomNavigate';

  static const  _kFontPkg = null;
  static const IconData undo = IconData(0xe800, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData truck = IconData(0xe800, fontFamily: _truck, fontPackage: _kFontPkg);
  static const IconData navigate = IconData(0xe800, fontFamily: _navigate, fontPackage: _kFontPkg);
}