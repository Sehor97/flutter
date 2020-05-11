import 'package:flutter/material.dart';
import 'package:http/http.dart'
as http;

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State < AddData > {
  TextEditingController controllerId = new TextEditingController();
  TextEditingController controllerNombre = new TextEditingController();
  TextEditingController controllerApellido = new TextEditingController();
  TextEditingController controllerUser = new TextEditingController();
  TextEditingController controllerPass = new TextEditingController();
  TextEditingController controllerNivel = new TextEditingController();

  String mensaje = "";
  var id = GlobalKey < FormState > ();

  void addData() {
    var url = "http://192.168.0.7/proyecto/adddata.php";
    http.post(url, body: {
      "id": controllerId.text,
      "nombre": controllerNombre.text,
      "apellido": controllerApellido.text,
      "user": controllerUser.text,
      "pass": controllerPass.text,
      "nivel": controllerNivel.text,

    });
  }


  @override
  Widget build(BuildContext context) {
    return
    Scaffold(
      appBar: AppBar(
        title: new Text("Registrarse"),
      ),
      body: Form(
        key: id,
        child: Padding(

          padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: < Widget > [
                new Column(
                  children: < Widget > [
                    new ListTile(
                      leading: const Icon(Icons.person_pin, color: Colors.blueAccent, ),
                        title: new TextFormField(
                          controller: controllerId,
                          decoration: new InputDecoration(
                            hintText: "ID", labelText: "ID",
                          ),
                        ),
                    ),
                    new ListTile(
                      leading: const Icon(Icons.person, color: Colors.blueAccent, ),
                        title: new TextFormField(
                          controller: controllerNombre,
                          validator: (value) {
                            if (value.isEmpty) return "Ingrese el nombre";

                          },
                          decoration: new InputDecoration(
                            hintText: "Nombre", labelText: "Nombre",
                          ),
                        ),
                    ),
                    new ListTile(
                      leading: const Icon(Icons.person, color: Colors.blueAccent, ),
                        title: new TextFormField(
                          controller: controllerApellido,
                          validator: (value) {
                            if (value.isEmpty) return "Ingrese el apellido";

                          },
                          decoration: new InputDecoration(
                            hintText: "Apellido", labelText: "Apellido",
                          ),
                        ),
                    ),

                    new ListTile(
                      leading: const Icon(Icons.email, color: Colors.blueAccent, ),
                        title: new TextFormField(
                          controller: controllerUser,
                          validator: (value) {
                            if (value.isEmpty) return "Ingrese el correo";

                          },
                          decoration: new InputDecoration(
                            hintText: "Email", labelText: "Email",
                          ),
                        ),
                    ),

                    new ListTile(
                      leading: const Icon(Icons.vpn_key, color: Colors.blueAccent, ),
                        title: new TextFormField(
                          controller: controllerPass,
                          obscureText: true,
                          validator: (value) {
                            if (value.isEmpty) return "Ingrese la contraseña";

                          },
                          decoration: new InputDecoration(
                            hintText: "Contraseña", labelText: "Contraseña",
                          ),
                        ),
                    ),

                    new ListTile(
                      leading: const Icon(Icons.accessible, color: Colors.blueAccent, ),
                        title: new TextFormField(
                          controller: controllerNivel,
                          validator: (value) {
                            if (value.isEmpty) return "Ingrese el nivel del usuario";

                          },
                          decoration: new InputDecoration(
                            hintText: "Nivel", labelText: "Nivel",
                          ),
                        ),
                    ),
                    new Padding(
                      padding: const EdgeInsets.all(10.0),
                    ),
                    new IconButton(
                      icon: Icon(Icons.fingerprint),
                      color: Colors.blueAccent,
                      tooltip: "Ponga el índice en el ícono de huella para finalizar el registro",
                      iconSize: 200.0,
                      onPressed: null
                    ),

                    new RaisedButton(
                      child: new Text("Enviar"),
                      color: Colors.blueAccent,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      onPressed: () {
                        if (id.currentState.validate()) {
                          addData();
                          mensaje = "Se registró exitosamente";
                          Navigator.pushReplacementNamed(context, '/menuPage');
                          //Navigator.pop(context);
                        }
                      },
                    ),

                    new RaisedButton(
                      child: new Text("Salir"),
                      color: Colors.blueAccent,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/LoginPage');
                      }
                    ),
                  ],
                )
              ],
            ),
        )
      )
    );
  }
}