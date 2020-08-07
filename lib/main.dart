import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:testpai/boxResults.dart';
import 'package:testpai/listaEstados.dart';
import 'package:testpai/models/APIBrasil.dart';
import 'package:testpai/models/APIDataBrasil.dart';
import 'models/API.dart';

void main() {
  runApp(MyApp());
}

final ScrollController controller = ScrollController();

bool isSearching = true;
TextEditingController dataController = TextEditingController();
int dataPesquisa;
bool pesquisaPorData = false;

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

Future<APIDataBrasil> getDadosBrasilPorData() async {
  final String url = "https://covid19-brazil-api.now.sh/api/report/v1/brazil/" +
      dataController.text;
  http.Response response = await http.get(url);
  final jsonresponse = jsonDecode(response.body);

  return APIDataBrasil.fromJson(jsonresponse);
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
              });
            },
          ),
          IconButton(
            icon: Image.asset('assets/brasil.png'),
            onPressed: null,
          ),
        ],
        title: isSearching
            ? const Text(
                'COVID-19 BRASIL',
                style: const TextStyle(
                  color: Colors.white,
                ),
              )
            : TextField(
                controller: dataController,
                onSubmitted: (_) {
                  setState(() {
                    pesquisaPorData = true;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Digite uma Data ex: (20200420)',
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
                      child: const CircularProgressIndicator(),
                    );
                  }
                },
              ),
              pesquisaPorData
                  ? FutureBuilder<APIDataBrasil>(
                      future: getDadosBrasilPorData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                            height: 300,
                            child: ListView.builder(
                                itemCount: snapshot.data.data.length,
                                itemBuilder: (ctx, i) {
                                  int contador = i + 1;
                                  return ListTile(
                                      leading: Text(contador.toString()),
                                      title: Text(
                                        snapshot.data.data[i].state,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      subtitle: Text(
                                          'CASOS: ${snapshot.data.data[i].cases.toString()}'),
                                      trailing: Text(
                                          'MORTES: ${snapshot.data.data[i].deaths.toString()}'));
                                }),
                          );
                        } else {
                          return Center(
                            child: const CircularProgressIndicator(),
                          );
                        }
                      },
                    )
                  : FutureBuilder<API>(
                      future: getDados(),
                      builder: (context, pegaDados) {
                        if (pegaDados.hasData) {
                          return ListaEstados(pegaDados);
                        } else {
                          return Center(
                            child: const CircularProgressIndicator(),
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
