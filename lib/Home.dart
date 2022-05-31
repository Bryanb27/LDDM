import 'package:flutter/material.dart';
//import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
//import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:progresso/progresso.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';


class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  _recuperarBancoDados( ) async {
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, "banco4.bd");
    var bd = await openDatabase(
        localBancoDados,
        version: 8,
        onCreate: (db, dbVersaoRecente){
          String Usuario = "CREATE TABLE USUARIO("
              "id INTEGER PRIMARY KEY AUTOINCREMENT,"
              "nome TEXT NOT NULL,"
              "perguntas_certas INTEGER,"
              "perguntas_totais INTEGER);";
          String Materia = "CREATE TABLE MATERIA("
              "idmateria INTEGER PRIMARY KEY AUTOINCREMENT,"
              "nome_materia TEXT);";
          String Pergunta = "CREATE TABLE PERGUNTA ("
              "idpergunta INTEGER PRIMARY KEY AUTOINCREMENT,"
              "enunciado TEXT,"
              "fk_idmateria INTEGER,"
              //"FOREIGN KEY (fk_idmateria) REFERENCES MATERIA(idmateria),"
              "alternativas_erradas TEXT,"
              "alternativa_correta TEXT);";
      //    db.execute(Usuario);


          db.execute(Materia);
          db.execute(Pergunta);
          db.execute(Usuario);
          Map<String, dynamic> dadosMateria = {
            "nome_materia" : "Literatura",
          };
          db.insert("MATERIA", dadosMateria);
          dadosMateria = {
            "nome_materia" : "Historia",
          };
          db.insert("MATERIA", dadosMateria);
          dadosMateria = {
            "nome_materia" : "Ciencia",
          };
          db.insert("MATERIA", dadosMateria);
          dadosMateria = {
            "nome_materia" : "Geografia",
          };
          db.insert("MATERIA", dadosMateria);
     //     db.execute(Pergunta);
        }
    );
    print("aberto: " + bd.isOpen.toString() );
    return bd;
  }
  _InserirPergunta( ) async{
    Database bd = await _recuperarBancoDados();

    Map<String, dynamic> dadosMateria = {
      "enunciado" : "QUANTAS LUAS TEM EM JÚPITER?",
      "fk_idmateria" : 2,
      "alternativas_erradas" : "49,67,98",
      "alternativa_correta" : "79"
    };
    bd.insert("PERGUNTA", dadosMateria);

    dadosMateria = {
      "enunciado" : "QUEM FUNDOU A FÁBRICA DE AUTOMÓVEIS FORD?",
      "fk_idmateria" : 1,
      "alternativas_erradas" : "HARRISON FORD,GERALD FORD,ANNA FORD",
      "alternativa_correta" : "HENRY FORD"
    };
    bd.insert("PERGUNTA", dadosMateria);

    dadosMateria = {
      "enunciado" : "O RIO AMAZONAS PERTENCE A QUAL CONTINENTE?",
      "fk_idmateria" : 3,
      "alternativas_erradas" : "AFRICANO,EUROPEU,ASIATICO",
      "alternativa_correta" : "AMERICANO"
    };
    bd.insert("PERGUNTA", dadosMateria);

    dadosMateria = {
      "enunciado" : "QUAL PERSONAGEM LIDERA O BANDO DA FLORESTA DE SHERWOOD?",
      "fk_idmateria" : 0,
      "alternativas_erradas" : "ROBIN COOK,ROBIN BANKS,ROBIN DAYS",
      "alternativa_correta" : "ROBIN HOOD"
    };
    bd.insert("PERGUNTA", dadosMateria);

    //teste
    String sql = "SELECT * FROM PERGUNTA";
    List material = await bd.rawQuery(sql);
    for(var usu in material){
      print(" id: "+usu['idpergunta'].toString() +
          " enunciado: "+usu['enunciado'] +
          " idmateria: "+usu['fk_idmateria'].toString() +
          " wrong: "+usu['alternativas_erradas']+
          " right: "+usu['alternativa_correta']);
    }
    sql = "SELECT * FROM MATERIA";
    material = await bd.rawQuery(sql);
    for(var usu in material){
      print(" id: "+usu['idmateria'].toString() +
          " nome: "+usu['nome_materia']);
    }
  }

  _InserirUsuario( ) async{
    Database bd = await _recuperarBancoDados();
    Map<String, dynamic> dadosMateria = {
      "nome" : "Bryan",
      "perguntas_certas" : 3,
      "perguntas_totais" : 1,
    };
    bd.insert("USUARIO", dadosMateria);

    //teste
    String sql = "SELECT * FROM USUARIO";
    List material = await bd.rawQuery(sql);
    for(var usu in material){
      print(" id: "+usu['id'].toString() +
          " nome: "+usu['nome'] +
          " perguntas_certas: "+usu['perguntas_certas'].toString() +
          " perguntas_totais: "+usu['perguntas_totais'].toString());
    }
  }

  /*_listarUsuarios() async{
    Database bd = await _recuperarBancoDados();
    String sql = "SELECT * FROM MATERIA";
    Map<String, dynamic> dadosMateria = {
      "idmateria" : 1,
      "nome_materia" : "Matematica",
    };
    int id = await bd.insert("MATERIA", dadosMateria);

    List material = await bd.rawQuery(sql);
    for(var usu in material){
      print(" id: "+usu['idmateria'].toString() +
          " nome: "+usu['nome_materia']);
      }
      }*/

  @override
  Widget build(BuildContext context) {

    //Database db = _recuperarBancoDados();

    double geografiaPercent = 32.0;
    int historiaPercent = 30;
    int literaturaPercent = 32;
    int cienciasPercent = 30;

    //_InserirMateria("")

    return Scaffold(
      appBar: AppBar(
        title: Text("Icone + Nome do jogador"),
      ),
      body: Container(
        color: Colors.grey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(6.0),
                        child: SizedBox(
                          width: 150,
                          height: 80,
                          child: ElevatedButton(
                            child: Text("Procurar/Criar sala"),
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                "/Lista",
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(6.0),
                        child: SizedBox(
                          width: 150,
                          height: 80,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                            ),
                            child: Text("Jogo rápido"),
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                "/Lista",
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ),
             Center(   //comment tava aqui
                child: Container(

                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text("Desempenho"),
                      Container(
                        // height: 86,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 1),
                              child: Column(children: [
                                Text("Desempenho"),
                                FAProgressBar(
                                  currentValue: geografiaPercent,
                                  displayText: '%',
                                  progressColor: Colors.blue,
                                  backgroundColor: Colors.white,
                                ),
                              ]))),
                      Container(
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 10, 20, 1),
                              child: Column(children: [
                                Text("Desempenho"),
                                FAProgressBar(
                                  currentValue: geografiaPercent,
                                  displayText: '%',
                                  progressColor: Colors.blue,
                                  backgroundColor: Colors.white,
                                ),
                              ]))),
                      Container(
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 10, 20, 1),
                              child: Column(children: [
                                Text("Desempenho"),
                                FAProgressBar(
                                  currentValue: geografiaPercent,
                                  displayText: '%',
                                  progressColor: Colors.blue,
                                  backgroundColor: Colors.white,
                                ),
                              ]))),
                      Container(
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 10, 20, 15),
                              child: Column(children: [
                                Text("Desempenho"),
                                FAProgressBar(
                                  currentValue: geografiaPercent,
                                  displayText: '%',
                                  progressColor: Colors.blue,
                                  backgroundColor: Colors.white,
                                ),
                              ]))),
                    ],
                  ),
                  color: Colors.black12,
                )
            )
          ],
        )
      ),
    );
  }
}