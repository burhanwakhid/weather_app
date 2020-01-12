import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/services/api_service.dart';

void main() {
  group("REST API Test", () {
    var api = ApiService();
    test('Data Weather', () async {
      var result = await api.fetchDataWeather('-7.5591993', '110.82100835');
      print('RESULT ${result.name}');
      expect(result.name == 'Surakarta', true);
    });

    test('City Weather', () async {
      var result = await api.fetchCityWeather('Surakarta');
      print('RESULT ${result.coord.lat}');
      expect(result != null, true);
    });
  });
}