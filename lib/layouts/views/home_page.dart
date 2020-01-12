import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/view_models/weather_vm.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  
  @override
  void initState() {
    Provider.of<WeatherProvider>(context, listen: false).connectionChanged();
    Provider.of<WeatherProvider>(context, listen: false).getDataWeather();
    Provider.of<WeatherProvider>(context, listen: false).getDataOffline();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
      var now = new DateTime.now();
      var formatter = new DateFormat('dd MMMM yyyy');
      String formatted = formatter.format(now);
    return Scaffold(
      body: SmartRefresher(
        controller: _refreshController,
        enablePullUp: true,
        header: WaterDropHeader(),
        onRefresh: () async {
          await Future.delayed(Duration(milliseconds: 1000));
          
          Provider.of<WeatherProvider>(context, listen: false).connectionChanged();
        
          Provider.of<WeatherProvider>(context, listen: false).getDataWeather();
        
          Provider.of<WeatherProvider>(context, listen: false).getDataOffline();
        
          if (mounted) setState(() {});
          _refreshController.refreshCompleted();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Consumer<WeatherProvider>(
                      builder: (context, model, _) => StreamBuilder<bool>(
                        stream: model.isLoading,
                        builder: (context, snapshot) {
                          if(model.isOffline == true) {
                            return (model.message != null) ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(30))
                              ),
                              child: Card(
                                elevation: 4.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[

                                    Text(model.city, style: TextStyle(fontSize: 30),),
                                    Text(formatted, style: TextStyle(color: Colors.grey),),
                                    SizedBox(height: 30,),
                                    Center(
                                      child: Column(
                                        children: <Widget>[
                                          Text(model.iconWeather, style: TextStyle(fontSize: 80)),
                                          Text(model.suhu.round().toString() +'°C', style: TextStyle(fontSize: 40),),                                
                                          Text(model.description),
                                          Text(model.message),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                                          ),
                              ),
                            ) : Text("You are Offline.\nYou Should connect internet first");
                          }
                          
                           if(snapshot.data != true){
                            print('ce');
                            print(model.isOffline);
                              return Center(child: CircularProgressIndicator(),);
                            }
                          
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(30))
                            ),
                            child: Card(
                              elevation: 4.0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[

                                  Text(model.weatherModel.name, style: TextStyle(fontSize: 30),),
                                  Text(formatted, style: TextStyle(color: Colors.grey),),
                                  SizedBox(height: 30,),
                                  Center(
                                    child: Column(
                                      children: <Widget>[
                                        Text(model.iconWeather, style: TextStyle(fontSize: 80)),
                                        Text((model.weatherModel.main.temp - 273.15).round().toString() +'°C', style: TextStyle(fontSize: 40),),                                
                                        Text(model.weatherModel.weather[0].description),
                                        Text(model.message),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                                                        ),
                            ),
                          );
                        },
                      ),
                      
                    ),
                    SizedBox(height: 45,),
                     TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Search Weather by City',
                        ),
                        controller: cityController
                      ),

                    Center(
                      child: Consumer<WeatherProvider>(
                        builder: (context, model, _) => StreamBuilder<bool>(
                          stream: model.isLoading,
                          builder: (context, snapshot) {
                            return RaisedButton(
                              onPressed: () {
                                model.getCityWeather(cityController.text);
                                print(cityController.text);
                              },
                              child: Text('Search'),
                            );
                          }
                        ),
                      ),
                     
                    ),
                     Consumer<WeatherProvider>(
                       builder: (context, model, _)=> StreamBuilder<bool>(
                         stream: model.isLoading,
                         builder: (context, snapshot) {
                           if(model.cityWeatherModel == null) {
                             return Container();
                           }
                           return Container(
                             width: double.infinity,
                             child: Card(
                                elevation: 4.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: <Widget>[
                                      Text(model.cityiconWeather, style: TextStyle(fontSize: 80)),
                                      Text((model.cityWeatherModel.main.temp - 273.15).round().toString()+'°C', style: TextStyle(fontSize: 40),),                                
                                      Text(model.cityWeatherModel.weather[0].description),
                                      Text(model.citymessage),
                                    ],
                                  ),
                                ),
                              ),
                           );
                         }
                       ),
                     )
                  ],
                )
              ),
            ),
          ),
        ),
      ),
    );
  }
}