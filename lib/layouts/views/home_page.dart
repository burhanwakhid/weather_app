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

  TextEditingController cityController = TextEditingController();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  
  @override
  void initState() {
    // Provider.of<WeatherProvider>(context, listen: false).getDataWeather();
    super.initState();
    WidgetsBinding.instance
      .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }

  Future<Null> _refresh() {
   return Provider.of<WeatherProvider>(context, listen: false).getDataWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: SafeArea(
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
                      Text(model.message),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Search Weather by City',
                        ),
                        controller: cityController
                      ),
                      RaisedButton(
                        onPressed: () {
                          print(cityController.text);
                        },
                        child: Text('Search'),
                      )
                    ],
                  );
                },
              ),
              
            )
          ),
        ),
      ),
    );
  }
}