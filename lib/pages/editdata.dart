import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:prueba_sesnsor_huella/pages/consultarPage.dart';

class EditData extends StatefulWidget {
  final List list;
  final int index;

  EditData({
    this.list,
    this.index
  });
  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State < EditData > {

  TextEditingController controllerUser;
  TextEditingController controllerPass;
  TextEditingController controllerNivel;

  void editData() {
    var url = "http://192.168.1.76/proyecto/editdata.php";
    http: post(url, body: {
      "id": widget.list[widget.index]['id'],
      "user": controllerUser.text,
      "pass": controllerPass.text,
      "nivel": controllerNivel.text,

    });
  }
  @override
  void initState() {
    controllerUser = new TextEditingController(text: widget.list[widget.index]['user']);
    controllerPass = new TextEditingController(text: widget.list[widget.index]['pass']);
    controllerNivel = new TextEditingController(text: widget.list[widget.index]['nivel']);
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Editar"),
      ),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.all(10.0),
            children: < Widget > [
              new ListTile(
                leading: const Icon(Icons.person, color: Colors.black),
                  title: new TextFormField(
                    controller: controllerUser,
                    validator: (value) {
                      if (value.isEmpty) return "Ingrese usuario";
                    },
                    decoration: new InputDecoration(
                      hintText: "Usuario", labelText: "Usuario",
                    ),
                  ),
              ),
              new ListTile(
                leading: const Icon(Icons.location_on, color: Colors.black),
                  title: new TextFormField(
                    controller: controllerPass,
                    validator: (value) {
                      if (value.isEmpty) return "Ingrese una contraseña";
                    },
                    decoration: new InputDecoration(
                      hintText: "Contraseña", labelText: "Contraseña",
                    ),
                  ),
              ),
              new ListTile(
                leading: const Icon(Icons.location_on, color: Colors.black),
                  title: new TextFormField(
                    controller: controllerNivel,
                    validator: (value) {
                      if (value.isEmpty) return "Ingrese el nivel";
                    },
                    decoration: new InputDecoration(
                      hintText: "Nivel", labelText: "Nivel",
                    ),
                  ),
              ),
              const Divider(
                  height: 1.0,
                ),
                new Padding(
                  padding: const EdgeInsets.all(10.0),
                ),
                new RaisedButton(
                  child: new Text("Guardar"),
                  color: Colors.black,
                  onPressed: () {
                    editData();
                    Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new Consulta()
                    ));
                  }
                )
            ],
        ),
      )

    );
  }
}