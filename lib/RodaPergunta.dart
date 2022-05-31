import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'dart:io';
import 'dart:math';

import 'package:list_app/Pergunta.dart';

class RodaPergunta extends StatefulWidget{
  @override
  _RodaPergunta createState() => _RodaPergunta();
}

class _RodaPergunta extends State<RodaPergunta> {
  StreamController<int> selected = StreamController<int>();
  final items = <String>[
    'Literatura',
    'Historia',
    'Ciências',
    'Geografia',
  ];
  var rng = Random();
  int tmp = null;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    String _tipoPergunta;

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Fortune Wheel'),
      ),
      body: Container(
        color: Colors.amber,

          child: Column(
            children: [
              Expanded(
                child: FortuneWheel(
                  indicators: <FortuneIndicator>[
                    FortuneIndicator(
                      alignment: Alignment.topCenter, // <-- changing the position of the indicator
                      child: TriangleIndicator(
                        color: Colors.red, // <-- changing the color of the indicator
                      ),
                    ),
                  ],
                  onFling: (){
                    tmp = rng.nextInt(5);
                    selected.add(tmp);
                    Future.delayed(const Duration(milliseconds: 6000), () {
                      setState(() {
                        // final time = await Future.delayed(Duration(seconds: 10)).then((value) => DateTime.now());

                        selected.add(
                          Fortune.randomInt(0, items.length),
                        );
                        // Here you can write your code for open new view

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Pergunta(tipo_Pergunta: this.tmp%4)
                          ),
                        );

                      });
                    }
                    );
                  },
                  items: [
                    for (var it in items) FortuneItem(child: Text(it)),
                  ],
                  selected: selected.stream,
                ),
              ),
            ],
          ),
      ),
    );
  }
}

