import 'package:flutter/material.dart';
import 'package:http/http.dart'
as http;

import 'consultarPage.dart';
import 'editdata.dart';

class Detail extends StatefulWidget {

  List list;
  int index;
  Detail({
    this.index,
    this.list
  });
  @override
  _DetailState createState() => _DetailState();
}


class _DetailState extends State < Detail > {

  void deleteData() {
    var url = "http://192.168.0.7/proyecto/deleteData.php";
    http.post(url, body: {
      'id': widget.list[widget.index]['id']
    });
  }


  void Confirmar() {
    AlertDialog alertDialog = new AlertDialog(
      content: new Text("Seguro desea eliminar '${widget.list[widget.index]['user']}'"),
      actions: < Widget > [
        new RaisedButton(
          child: new Text("Eliminado", style: new TextStyle(color: Colors.black), ),
          color: Colors.red,
          onPressed: () {
            deleteData();
            Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (BuildContext context) => new Consulta(),
              )
            );
          },
        ),

        new RaisedButton(
          child: new Text("Cancelar", style: new TextStyle(color: Colors.black), ),
          color: Colors.green,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    showDialog(context: context, child: alertDialog);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: new Text("${widget.list[widget.index]['user']}"), ),
      body: new Container(
        height: 270.0,
        padding: const EdgeInsets.all(20.0),
          child: new Card(
            child: new Center(
              child: new Column(
                children: < Widget > [
                  new Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                  ),
                  new Text(widget.list[widget.index]['user'], style: new TextStyle(fontSize: 20.0), ),
                  Divider(),
                  new Text("Nivel: ${widget.list[widget.index]['nivel']}", style: new TextStyle(fontSize: 18.0), ),
                  new Padding(padding: const EdgeInsets.only(top: 30.0), ),

                  new Row(
                    mainAxisSize: MainAxisSize.min,
                    children: < Widget > [
                      new RaisedButton(
                        child: new Text("Editar"),
                        color: Colors.blueAccent,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        onPressed: () => Navigator.of(context).push(
                          new MaterialPageRoute(
                            builder: (BuildContext context) => new EditData(list: widget.list, index: widget.index, ),
                          )
                        ),
                      ),
                      VerticalDivider(),
                      new RaisedButton(
                        child: new Text("Eliminar"),
                        color: Colors.redAccent,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        onPressed: () => Confirmar(),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
      ),

    );
  }
}