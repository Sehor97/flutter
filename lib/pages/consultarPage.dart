import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'
as http;
import 'dart:async';
import 'dart:convert';

import 'package:prueba_sesnsor_huella/pages/registresePage.dart';

import 'detail.dart';

class Consulta extends StatefulWidget {
  @override
  _ConsultaState createState() => _ConsultaState();
}

class _ConsultaState extends State < Consulta > {

  Future < List > getData() async {
    final response = await http.get("http://192.168.1.76/proyecto/getdata.php");
    return json.decode(response.body);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Listado de usuarios"),
        
      ),


      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new AddData(),
          ), );
        }
      ),


      body: new FutureBuilder < List > (
        future: getData(),
        builder: (context, snapshop) {
          if (snapshop.hasError) print(snapshop.error);
          return snapshop.hasData ?
            new ItemList(
              list: snapshop.data,
            ) :
            new Center(
              child: new CircularProgressIndicator(),
            );
        }
      ),
    );
  }
}
class ItemList extends StatelessWidget {
  final List list;
  ItemList({
    this.list
  });

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          padding: const EdgeInsets.all(10.0),
            child: new GestureDetector(
              onTap: () => Navigator.of(context).push(
                new MaterialPageRoute(
                  builder: (BuildContext context) => new Detail(
                    list: list,
                    index: i,
                  )
                ),
              ),
              child: new Card(
                child: new ListTile(
                  title: new Text(
                    list[i]['user'],
                    style: TextStyle(fontSize: 25.0, color: Colors.lightBlueAccent),
                  ),
                  leading: new Icon(
                    Icons.person_pin,
                    size: 77.0,
                    color: Colors.orangeAccent,
                  ),
                  subtitle: new Text(
                    "Nivel: ${list[i]['nivel']}",
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                ),
              ),
            ),
        );
      }
    );
  }
}