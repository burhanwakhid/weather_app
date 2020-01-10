import 'package:weather_app/core/constant/constant.dart';
import 'package:weather_app/core/models/weather_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
class ApiService {

  Future<WeatherModel> fetchDataWeather(lat, long) async{
    try{
      var url = apiOpenWeather+'lat=$lat&lon=$long&appid=$keyOpenWeather';
      var response = await http.get(url);
      if(response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(url);
        print(data);
        WeatherModel result = WeatherModel.fromJson(data);
        return result;
      }else {
        throw Exception('Something error');
      }
    }catch(e){  
      throw Exception(e);
    }
  }
}