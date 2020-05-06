import 'package:flutter/material.dart';
import 'package:prueba_sesnsor_huella/pages/consultarPage.dart';
import 'package:prueba_sesnsor_huella/pages/registrarHuellaPage.dart';
import 'package:prueba_sesnsor_huella/pages/registresePage.dart';
import 'package:prueba_sesnsor_huella/main.dart';
import 'package:prueba_sesnsor_huella/pages/consultarPage.dart';
import 'package:http/http.dart'as http;
//import 'package:prueba_sesnsor_huella/pages/consultarPage.dart';
//import 'package:http/http.dart' as http;
//import 'package:flutter/src/material/user_accounts_drawer_header.dart';


void main() => runApp(Menu());

class Menu extends StatelessWidget{
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ARQUITECTURA DE SOFTWARE",
      theme: ThemeData(
         brightness: Brightness.dark,
        //primarySwatch: Colors.blue,
    ),
    home:
    
     Scaffold(
      appBar: AppBar(title: Text("Menú de Usuario"),),
      drawer: MenuLateral(),
      body:  Form(
        child: Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/fondo.jpeg"),
              fit: BoxFit.cover
          
            ),
          ),
          child: Center(
            child: Column(
              children: <Widget>[
                 IconButton(
                    color: Colors.blueAccent,
                    icon: Icon(Icons.fingerprint), 
                    tooltip: "Ponga el índice en el ícono de huella para abrir la puerta",
                    iconSize: 200.0,
                    onPressed: null
                    ),
              ]
            ),
          )
    ),
    
      ),
    ),
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


class MenuLateral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: Text('${['nombre']}'), 
            accountEmail: Text('${['user']}'),
            decoration: BoxDecoration(
              image: new DecorationImage(
                image:new AssetImage("assets/images/lo.png"),
                fit: BoxFit.cover
                )
            ),

            ),
            Ink(
              color: Colors.indigo,
              child: new ListTile(
                title: Text("!Bienvenido!", style: TextStyle(color: Colors.white),),
              ),
            ), 
            new ListTile(
              title:Text("Consultar"),
              onTap: (){
                Navigator.pushReplacementNamed(context, '/ConsultarPage');
                
              },
              //onTap:() => Navigator.pushReplacementNamed(context, '/consultarPage'),
            ),
            new ListTile(
              title:Text("Registrar Invitado"),
              onTap: (){
                Navigator.pushReplacementNamed(context, '/registrarHuellaPage');
                
              },
              //onTap:() => Navigator.pushReplacementNamed(context, '/consultarPage'),
            ),
            new Column(
              children: <Widget>[
                RaisedButton(
                  child: Text("Cerrar Sesión") ,
                  onPressed:(){
                    Navigator.pushReplacementNamed(context, '/LoginPage');
                  } ,
                  )
              ]

            )
        ],
      ),
      
    );
  }
}

