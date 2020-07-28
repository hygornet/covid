import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:testpai/boxResults.dart';
import 'package:testpai/listaEstados.dart';
import 'package:testpai/models/APIBrasil.dart';
import 'models/API.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  runApp(MyApp());
}

Future<API> getDados() async {
  final String url = "https://covid19-brazil-api.now.sh/api/report/v1";
  http.Response response = await http.get(url);
  final jsonresponse = jsonDecode(response.body);

  return API.fromJson(jsonresponse);
}

Future<APIBrasil> getDadosBrasil() async {
  final String url = "https://covid19-brazil-api.now.sh/api/report/v1/brazil";
  http.Response response = await http.get(url);
  final jsonresponse = jsonDecode(response.body);

  return APIBrasil.fromJson(jsonresponse);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'COVID-19 Brasil',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getDados();
    getDadosBrasil();
    initializeDateFormatting('pt_BR', null).then((_) => runApp(MyApp()));
  }

  int contador;
  var dt;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Image.asset('assets/brasil.png'),
            onPressed: null,
          ),
        ],
        title: Text(
          'COVID-19 BRASIL',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            children: <Widget>[
              FutureBuilder<APIBrasil>(
                future: getDadosBrasil(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return BoxResults(snapshot);
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              FutureBuilder<API>(
                  future: getDados(),
                  builder: (context, pegaDados) {
                    if (pegaDados.hasData) {
                      return ListaEstados(pegaDados);
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
