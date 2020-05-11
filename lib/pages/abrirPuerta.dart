import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'menuPage.dart';


class MyApp extends StatelessWidget {
  String name;
  String user;
  MyApp(this.name,this.user);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        //primarySwatch: Colors.blue,
      ),
      home: MyHomePage(context, title: "ABRIR PUERTA"),
      routes: < String, WidgetBuilder > {
        '/menuPage': (BuildContext context) => new Menu(name, user),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  BuildContext contexts;
  MyHomePage(
    this.contexts, {
      Key key,
      this.title
    }): super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState(contexts);
}

class _MyHomePageState extends State < MyHomePage > {
  BuildContext contextf;
  _MyHomePageState(this.contextf);
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  bool _hasFingerPrintSupport = false;

  String _authorizedOrNot = "No autorizado";

  List < BiometricType > _availableBuimetricType = List < BiometricType > ();

  Future < void > _getBiometricsSupport() async {
    bool hasFingerPrintSupport = false;
    try {
      hasFingerPrintSupport = await _localAuthentication.canCheckBiometrics;
    } catch (e) {
      print(e);
    }
    if (!mounted) return;
    setState(() {
      _hasFingerPrintSupport = hasFingerPrintSupport;

    });
  }

  Future < void > _getAvailableSupport() async {
    List < BiometricType > availableBuimetricType = List < BiometricType > ();
    try {
      availableBuimetricType = await _localAuthentication.getAvailableBiometrics();
    } catch (e) {
      print(e);

    }
    if (!mounted) return;
    setState(() {
      _availableBuimetricType = availableBuimetricType;

    });
  }

  Future < void > _authenticateMe() async {
    bool authenticated = false;
    try {
      authenticated = await _localAuthentication.authenticateWithBiometrics(
        localizedReason: "Autenticación por prueba",
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } catch (e) {
      print(e);
    }
    if (!mounted) return;
    setState(() {
      _authorizedOrNot = authenticated ? "Autorizado" : "No Autorizado";
    });
  }


  @override
  void initState() {
    _getBiometricsSupport();
    _getAvailableSupport();
    super.initState();
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/menuPage');
          }
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: < Widget > [
            Text("Tiene soporte para huellas digitales: $_hasFingerPrintSupport"),
            Text(
              "Lista de soporte biometrico: ${_availableBuimetricType.toString()}"
            ),
            RaisedButton(
              child: Text("Abrir Puerta"),
              color: Colors.green,
              onPressed: _authenticateMe,
            ),
          ],
        ),
      ),
    );
  }
}