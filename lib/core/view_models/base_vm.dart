import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class BaseVM extends ChangeNotifier{
  final _isLoadingSubject = BehaviorSubject<bool>.seeded(false);

  Observable<bool> get isLoading => _isLoadingSubject.stream;

  void setBusy(){
    _isLoadingSubject.sink.add(true);
  }

  void setIdle(){
    _isLoadingSubject.sink.add(false);
  }

  void setError(String message){
    _isLoadingSubject.sink.addError(message);
  }

  @override
  void dispose() {
    _isLoadingSubject.close();
    super.dispose();
  }
}