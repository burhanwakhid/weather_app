import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/models/city_weather_model.dart';
import 'package:weather_app/core/models/detail_weather_model.dart';
import 'package:weather_app/core/models/weather_model.dart';
import 'package:weather_app/core/services/api_service.dart';
import 'package:weather_app/core/view_models/base_vm.dart';

class WeatherProvider extends BaseVM {
  final _api = ApiService();
  double latitude;
  double longitude;

  DetailWeatherModel detailWeatherModel = DetailWeatherModel();

  String _iconWeather;
  String get iconWeather => _iconWeather;
  set iconWeather(String val) {
    _iconWeather = val;
    notifyListeners();
  }

  String _citymessage;
  String get citymessage => _citymessage;
  set citymessage(String val) {
    _citymessage =val;
    notifyListeners();
  }

  String _cityiconWeather;
  String get cityiconWeather => _cityiconWeather;
  set cityiconWeather(String val) {
    _cityiconWeather = val;
    notifyListeners();
  }

  String _message;
  String get message => _message;
  set message(String val) {
    _message =val;
    notifyListeners();
  }

  WeatherModel _weatherModel;
  WeatherModel get weatherModel => _weatherModel;
  set weatherModel(WeatherModel val) {
    _weatherModel = val;
    notifyListeners();
  }

  CityWeatherModel _cityWeatherModel;
  CityWeatherModel get cityWeatherModel => _cityWeatherModel;
  set cityWeatherModel(CityWeatherModel val) {
    _cityWeatherModel =val;
    notifyListeners();
  }

  Future<void> getCityWeather(city) async {
    setIdle();
    cityWeatherModel = await _api.fetchCityWeather(city);
    cityiconWeather = detailWeatherModel.getWeatherIcon(cityWeatherModel.weather[0].id);
    double celcius = cityWeatherModel.main.temp - 273.15;
    citymessage = detailWeatherModel.getMessage(celcius.toInt());
    setBusy();
  }

  Future<void> getDataWeather() async{
    setIdle();
    Position position = await Geolocator()
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    latitude = position.latitude;
    longitude = position.longitude;
    print(latitude);
    weatherModel = await _api.fetchDataWeather(latitude, longitude);
    print(detailWeatherModel.getWeatherIcon(weatherModel.weather[0].id));
    iconWeather = detailWeatherModel.getWeatherIcon(weatherModel.weather[0].id);
    double celcius = weatherModel.main.temp - 273.15;
    message = detailWeatherModel.getMessage(celcius.toInt());
    setBusy();
  }
}