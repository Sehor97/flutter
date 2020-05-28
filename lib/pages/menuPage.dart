import 'package:flutter/material.dart';
import 'package:prueba_sesnsor_huella/pages/consultarPage.dart';
import 'package:prueba_sesnsor_huella/pages/registrarHuellaPage.dart';
import 'package:prueba_sesnsor_huella/pages/registresePage.dart';
import 'package:prueba_sesnsor_huella/main.dart';
import 'abrirPuerta.dart';



void main() => runApp(Menu('', ''));

class Menu extends StatelessWidget {
  String name;
  String user;
  Menu(this.name, this.user);

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ARQUITECTURA DE SOFTWARE",
      theme: ThemeData(
        brightness: Brightness.dark,
        //primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text("Menú de Usuario"), ),
        drawer: MenuLateral(name, user),
        body: Form(
          child: Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/fondo.jpeg"),
                fit: BoxFit.cover

              ),
            ),
            child: Center(
              child: Column(
                children: < Widget > [
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
      routes: < String, WidgetBuilder > {
        '/menuPage': (BuildContext context) => new Menu(name, user),
        '/registresePage': (BuildContext context) => new AddData(),
        '/registrarHuellaPage': (BuildContext context) => new AddDataH(),
        '/ConsultarPage': (BuildContext context) => new Consulta(),
        '/LoginPage': (BuildContext context) => new LoginPage(),
        '/abrirPuerta': (BuildContext context) => new MyApp(name, user),
      },
    );
  }
}


class MenuLateral extends StatelessWidget {
  String nam;
  String usr;
  MenuLateral(this.nam, this.usr);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: < Widget > [
          new UserAccountsDrawerHeader(
            accountName: Text(nam),
            accountEmail: Text(usr),
            decoration: BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/lo.png"),
                fit: BoxFit.cover
              )
            ),

          ),
          Ink(
            color: Colors.indigo,
            child: new ListTile(
              title: Text("!Bienvenido!", style: TextStyle(color: Colors.white), ),
            ),
          ),
          new ListTile(
            title: Text("Consultar"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/ConsultarPage');

            },
          ),
          new ListTile(
            title: Text("Registrar Invitado"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/registrarHuellaPage');

            },
          ),

          new ListTile(
            title: Text("Abrir puerta"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/abrirPuerta');

            },
          ),
          new Column(
            children: < Widget > [
              RaisedButton(
                child: Text("Cerrar Sesión"),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/LoginPage');
                },
              )
            ]

          )
        ],
      ),

    );
  }
}