import 'package:flutter/material.dart';
import 'Home.dart';
import 'RodaPergunta.dart';
import 'Pergunta.dart';
import 'Lista.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: "/",
    routes: {
      "/Roda": (context) => RodaPergunta(),
      "/Pergunta": (context) => Pergunta(),
      "/Lista": (context) => Lista(),
    },
    home: Home(),
  ));
}