import 'package:flutter/material.dart';
import 'package:flutter_burc_rehberi/burc_listesi.dart';


void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: _generateRoute,
      routes: Routes(),
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),


    );
  }

  Route _generateRoute(RouteSettings settings) {
    var gelenParametreler = settings.name.split('/');

    if (gelenParametreler[1] == 'burcDetay') {
      if(isNumeric(gelenParametreler[2])){
        return MaterialPageRoute(
            builder: (context) => BurcDetay(int.parse(gelenParametreler[2])));
      }

    }
  }

  Map<String, WidgetBuilder> Routes(){

  return {
    '/':(context) => BurcListesi()


  };


  }

  bool isNumeric(String s) {
    if(s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }

}

