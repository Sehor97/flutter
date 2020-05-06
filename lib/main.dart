import 'dart:convert';
//import 'dart:js';

import "package:flutter/material.dart";
import 'package:prueba_sesnsor_huella/pages/consultarPage.dart';
import 'package:prueba_sesnsor_huella/pages/menuPage.dart';
import 'package:prueba_sesnsor_huella/pages/registrarHuellaPage.dart';
import 'package:prueba_sesnsor_huella/pages/registresePage.dart';
import 'package:http/http.dart' as http;

void main() => runApp(LoginApp());

String user;

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "PROYECTO DE ARQUITECTURA",
      home: LoginPage(),
      routes: <String, WidgetBuilder>{
        '/menuPage': (BuildContext context) => new Menu(),
        '/registresePage': (BuildContext context) => new AddData(),
        '/registrarHuellaPage': (BuildContext context) => new AddDataH(),
        '/ConsultarPage': (BuildContext context) => new Consulta(),
        '/LoginPage': (BuildContext context) => new LoginPage(),
      },
      
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController controllerUser = new TextEditingController();
  TextEditingController controllerPass = new TextEditingController();

  

  String mensaje= "";

  Future<List> login() async {
    final response =await http.post("http://192.168.1.76/proyecto/login.php",
    body: {
      "user": controllerUser.text,
      "pass": controllerPass.text,

    });
  

  var datauser = json.decode(response.body);

  if (datauser.length == 0){
    setState(() {
      mensaje= "usuario o contraseña incorrectas";
    });

  }else {
    if (datauser[0]["nivel"]== "admin"){
      Navigator.pushReplacementNamed(context, '/menuPage');
    }else if(datauser[0]["nivel"] == "invitado"){
      Navigator.pushReplacementNamed(context, '/menuPage');
    }

    setState(() {
      user=datauser[0]["user"];
    });
    }
    return datauser;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Form(
        
        child: Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/fondo.jpeg"),
              fit: BoxFit.cover
          
            ),
          ),

          child: Column(
            children: <Widget>[
              new Container (
                padding: EdgeInsets.only(top: 77.0),
                child: new CircleAvatar(
                  backgroundColor: Color(0xF81F73),
                  child: new Image(
                    width: 135,
                    height: 135,
                    image: new AssetImage("assets/images/lo.png"),
                    ),
                ),

                width: 170.0,
                height: 170.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle
                ),
                ),

                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top:93
                  ),

                  child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        padding: EdgeInsets.only(
                          top:4, left: 16, right: 16, bottom: 4
                        ),

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Colors.black12,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white60,
                              blurRadius: 5
                            )
                          ]
                        ),

                        child: TextFormField(
                          controller: controllerUser,
                          validator: (value){
                        if(value.isEmpty) return "Ingrese su correo electrónico";

                      },
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.email,
                              color: Colors.blueAccent,
                            ),
                            hintText: "usuario"
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        height: 50,
                        margin: EdgeInsets.only(
                          top:32
                        ),

                        padding: EdgeInsets.only(
                          top: 4, left: 16, right: 16, bottom:4
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Colors.black12,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white60,
                              blurRadius:5
                            ),
                          ],
                        ),

                        child: TextField(
                          controller: controllerPass,
                          obscureText: true,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.vpn_key,
                              color: Colors.blueAccent
                            ),
                            hintText: "Contraseña"
                          ),
                        ),

                      ),
                    
                      
                      Spacer(),
                        new RaisedButton(
                          child: new Text("Ingresar"),
                          color: Colors.blueAccent,
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                          onPressed: (){
                            login();
                            //Navigator.pop(context);
                          },
                          ),
                          Text(mensaje,
                          style: TextStyle(fontSize: 25.0, color: Colors.red),
                          
                          ),
                          new RaisedButton(
                            child: new Text ("Registrarse"),
                            color: Colors.blueAccent,
                            shape: new RoundedRectangleBorder(
                            borderRadius:new BorderRadius.circular(30.0),
                          ),
                          onPressed: (){
                           Navigator.pushReplacementNamed(context, '/registresePage');
                         }
                       ),
                    ],
                  ),
                ),
                 new IconButton(
                    icon: Icon(Icons.fingerprint), 
                    color: Colors.blueAccent,
                    iconSize: 100.0,
                    onPressed: null
                    ),
            ],
          ),
        ),
        ),
      
    );
  }
}