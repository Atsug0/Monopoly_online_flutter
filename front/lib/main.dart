import 'package:flutter/material.dart';
import 'package:monopoly/controller/js_controller.dart';
import 'package:monopoly/vue/Plateau/plateau.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:monopoly/vue/app.dart';

void main() {
  JsManager.jsmanager.init();
  runApp(MyApp());
}
