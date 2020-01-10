import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/view_models/weather_vm.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WeatherProvider>(
      create: (_) => WeatherProvider(),
      child: HomePageView(),
    );
  }
}

class HomePageView extends StatefulWidget {
  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  
  @override
  void initState() {
    Provider.of<WeatherProvider>(context, listen: false).getDataWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Consumer<WeatherProvider>(
            builder: (context, model, _) => StreamBuilder<bool>(
              stream: model.isLoading,
              builder: (context, snapshot) {
                if(snapshot.data != true) {
                  return Center(child: CircularProgressIndicator(),);
                }
                return Column(
                  children: <Widget>[
                    Text(model.weatherModel.weather[0].description),
                    Text('City: '+model.weatherModel.name),
                    Text(model.iconWeather),
                    Text(model.message)
                  ],
                );
              },
            ),
            
          )
        ),
      ),
    );
  }
}