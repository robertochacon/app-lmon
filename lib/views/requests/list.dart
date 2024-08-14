import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lmon/models/request_model.dart';
import 'package:intl/intl.dart';

class ListRequest extends StatefulWidget {
  const ListRequest({super.key});

  @override
  State<ListRequest> createState() => _ListRequestState();
}

List<RequestModel> requsts = [];

Future<void> getRequests() async {
  requsts = [];
  var response = await http.get(Uri.parse('http://192.168.100.5:8000/api/requests'));
  var data = jsonDecode(response.body);

  for (var item in data['data']) {
    final request = RequestModel(
      identification: item['identification'],
      amount: item['amount'],
      quotas: item['quotas'],
      total: item['total'],
      status: item['status']
    );
    requsts.add(request);
  }
}

class _ListRequestState extends State<ListRequest> {
  Future<void> _refreshData() async {
    await getRequests();
    setState(() {}); // Update the UI
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitudes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshData,
          ),
        ],
      ),
      body: FutureBuilder(
        future: getRequests(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final currencyFormat = NumberFormat.currency(symbol: '\$');

            return ListView.builder(
              itemCount: requsts.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text('Monto: ${currencyFormat.format(requsts[index].amount)}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Cuotas: ${requsts[index].quotas}'),
                          Text('Total: ${currencyFormat.format(requsts[index].total)}'),
                          Text('Estado: ${requsts[index].status}'),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.info_outline), // Icono de detalles
                        onPressed: () {
                          // Acción al presionar el ícono
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Detalles'),
                                content: Text('Detalles de la solicitud aquí... ${requsts[index].quotas}'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Cerrar'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
