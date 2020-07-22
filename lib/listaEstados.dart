import 'package:flutter/material.dart';

import 'models/API.dart';

class ListaEstados extends StatefulWidget {
  AsyncSnapshot<API> pegaDados;

  ListaEstados(this.pegaDados);

  @override
  _ListaEstadosState createState() => _ListaEstadosState();
}

class _ListaEstadosState extends State<ListaEstados> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
          itemCount: widget.pegaDados.data.data.length,
          itemBuilder: (context, i) {
            return Card(
              elevation: 6,
              child: ListTile(
                title: Text(
                  widget.pegaDados.data.data[i].state,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                subtitle: Text(
                    'CASOS: ${widget.pegaDados.data.data[i].cases.toString()}'),
                trailing: Text(
                    'MORTES: ${widget.pegaDados.data.data[i].deaths.toString()}'),
              ),
            );
          }),
    );
  }
}
