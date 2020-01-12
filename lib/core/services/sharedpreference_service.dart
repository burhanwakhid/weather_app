import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

// const String _date = "date";
const String _city = 'city';
const String _icon = "icon";
const String _suhu = "suhu";
const String _weather = "weather";
const String _message = "message";

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

Future<String> getWeather() async 
{
  final SharedPreferences prefs = await _prefs;
  return prefs.getString(_weather) ?? false;
}

Future<bool> setWeather(String value) async
{
  final SharedPreferences prefs = await _prefs;
  return prefs.setString(_weather, value);
}

Future<String> getCity() async 
{
  final SharedPreferences prefs = await _prefs;
  return prefs.getString(_city) ?? false;
}

Future<bool> setCity(String value) async
{
  final SharedPreferences prefs = await _prefs;
  return prefs.setString(_city, value);
}

Future<String> getIcon() async 
{
  final SharedPreferences prefs = await _prefs;
  return prefs.getString(_icon) ?? false;
}

Future<bool> setIcon(String value) async
{
  final SharedPreferences prefs = await _prefs;
  return prefs.setString(_icon, value);
}

Future<double> getSuhu() async 
{
  final SharedPreferences prefs = await _prefs;
  return prefs.getDouble(_suhu) ?? false;
}

Future<bool> setSuhu(double value) async
{
  final SharedPreferences prefs = await _prefs;
  return prefs.setDouble(_suhu, value);
}

Future<String> getMessage() async 
{
  final SharedPreferences prefs = await _prefs;
  return prefs.getString(_message) ?? false;
}

Future<bool> setMessage(String value) async
{
  final SharedPreferences prefs = await _prefs;
  return prefs.setString(_message, value);
}




