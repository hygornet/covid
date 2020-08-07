import 'package:flutter/material.dart';
import 'models/API.dart';

class ListaEstados extends StatefulWidget {
  final AsyncSnapshot<API> pegaDados;

  ListaEstados(this.pegaDados);

  @override
  _ListaEstadosState createState() => _ListaEstadosState();
}

class _ListaEstadosState extends State<ListaEstados> {
  @override
  Widget build(BuildContext context) {
    int contador = 0;
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      child: ListView.builder(
          itemCount: widget.pegaDados.data.data.length,
          itemBuilder: (context, i) {
            contador = i + 1;
            return Card(
              elevation: 6,
              child: ListTile(
                leading: Text(contador.toString()),
                title: Text(
                  widget.pegaDados.data.data[i].state,
                  style: const TextStyle(
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
