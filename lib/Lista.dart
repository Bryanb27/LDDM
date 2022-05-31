import 'package:flutter/material.dart';
import 'package:counter/counter.dart';

class Lista extends StatefulWidget {
  @override
  _ListaState createState() => _ListaState();
}

class _ListaState extends State<Lista> {

  List _itens = [];

  void _carregarItens() {
    _itens = [];
    for (int i = 0; i <= 10; i++) {
      Map<String, dynamic> item = Map();
      item["titulo"] = "Titulo ${i} da lista";
      item["icone"] = Image.asset("icone.png");
      _itens.add(item);
    }
  }

  final titles = ["Jogador 1", "Jogador 2", "Jogador 3"];
  final subtitles = [
    "Pontuação",
    "Pontuação",
    "Pontuação"
  ];

//final icons = [Icons.airplanemode_off, Icons.access_alarm, Icons.access_time];

  @override
  Widget build(BuildContext context) {
    _carregarItens();
    Future.delayed(const Duration(milliseconds: 5000), () {
        Navigator.pushNamed(
          context,
          "/Roda",
        );
        // Here you can write your code for open new view
      });

    return Container(
      child: ListView.builder(
          itemCount: titles.length,
          itemBuilder: (context, index) {
            return Card(
                child: Center(
                    child: ListTile(
                      title: Center(child: Text(titles[index])),
                      subtitle: Center(child: Text(subtitles[index])),
                      leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://images.unsplash.com/photo-1547721064-da6cfb341d50")),
                      //trailing: Icon(icons[index])),
                    )));
          }),
    );
  }
}


 /*
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
            itemCount: _itens.length,
            itemBuilder: (context, indice) {
              //print("item ${indice}");
              //Map<String, dynamic> item =_itens[indice];
              //print("item ${_itens[indice]["titulo"]}");
              return ListTile(
                onTap: (){
                  //print("Clique com onTap ${indice}");
                  showDialog(
                      context: context,
                      builder: (context){
                        return AlertDialog(
                          title: Text(_itens[indice]["titulo"]),
                          titleTextStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                            backgroundColor: Colors.yellow,
                          ),
                          content: Text(_itens[indice]["descricao"]),
                          actions: <Widget>[ //definir widgets
                            TextButton(
                                onPressed: (){
                                  print("Selecionado sim");
                                  Navigator.pop(context);
                                },
                                child: Text("Sim")
                            ),
                            TextButton(
                                onPressed: (){
                                  print("Selecionado não");
                                  Navigator.pop(context);
                                },
                                child: Text("Não")
                            ),
                          ],
                        );
                      }
                  );
                },
                onLongPress: (){
                  //print("Clique com onLongPress ${indice}");
                },
                title: Text(_itens[indice]["titulo"]),
                subtitle: Text(_itens[indice]["descricao"]),
              );
            }
        ),
      ),
    );
  }


}

  */
