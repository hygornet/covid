import 'package:flutter/material.dart';
import 'package:testpai/models/APIBrasil.dart';
import 'package:url_launcher/url_launcher.dart';

class BoxResults extends StatefulWidget {
  AsyncSnapshot<APIBrasil> snapshot;

  BoxResults(this.snapshot);
  @override
  _BoxResultsState createState() => _BoxResultsState();
}

String urlSintomas = "https://coronavirus.saude.gov.br/sobre-a-doenca#sintomas";
String urlPerguntasFrequentes =
    "https://coronavirus.saude.gov.br/index.php/perguntas-e-respostas";
String urlDiagnostico =
    "https://coronavirus.saude.gov.br/sobre-a-doenca#diagnostico";

class _BoxResultsState extends State<BoxResults> {
  Future<void> _laucherInApp(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        headers: <String, String>{'headers_key': 'header_value'},
      );
    } else {
      return throw Exception('Erro ao abrir');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width / 2.2,
              height: 120,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.grey,
                  ),
                ],
                color: Colors.green,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 35.0),
                    child: Text(
                      "Confirmados",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    widget.snapshot.data.data.confirmed.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2.2,
              height: 120,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.grey,
                  ),
                ],
                color: Colors.red,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 35.0),
                    child: Text(
                      "Mortes",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    widget.snapshot.data.data.deaths.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text("Atualizado em: " + widget.snapshot.data.data.updatedAt),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _laucherInApp(urlPerguntasFrequentes);
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.amber.withOpacity(0.5)),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 80,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Image.asset('assets/mascara.png'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, left: 35),
                        child: Text(
                          'Perguntas Frequentes',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              shadows: [
                                Shadow(
                                  blurRadius: 3,
                                  color: Colors.black,
                                  offset: Offset(1, 3),
                                ),
                              ]),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _laucherInApp(urlSintomas);
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.purple.withOpacity(0.5)),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 80,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Image.asset('assets/sintomas.png'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, left: 35),
                        child: Text(
                          'Quais são os sintomas?',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  blurRadius: 3,
                                  color: Colors.black,
                                  offset: Offset(1, 3),
                                ),
                              ]),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _laucherInApp(urlDiagnostico);
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.red.withOpacity(0.5)),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 80,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Image.asset('assets/diagnostico2.png'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, left: 35),
                        child: Text(
                          'Diagnostico',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            shadows: [
                              Shadow(
                                blurRadius: 3,
                                color: Colors.black,
                                offset: Offset(1, 3),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
