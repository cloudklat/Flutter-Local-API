import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

//* Firebase
import 'package:cloud_firestore/cloud_firestore.dart';

class NetworkingHttpApp extends StatefulWidget {
  const NetworkingHttpApp({super.key});

  @override
  State<NetworkingHttpApp> createState() => _NetworkingHttpAppState();
}

class _NetworkingHttpAppState extends State<NetworkingHttpApp> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final inputNama = TextEditingController();
    final inputHarga = TextEditingController();
    final inputQuantity = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("Flutter w/ Spring"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    scrollable: true,
                    content: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                controller: inputNama,
                                decoration: const InputDecoration(
                                  labelText: 'Nama Produk',
                                  icon: Icon(Icons.playlist_add_rounded),
                                ),
                                // The validator receives the text that the user has entered.
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Mohon Masukan Nama';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: inputHarga,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: const InputDecoration(
                                  labelText: 'Harga',
                                  icon: Icon(Icons.price_change_rounded),
                                ),
                                // The validator receives the text that the user has entered.
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Mohon Masukan Harga';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: inputQuantity,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: const InputDecoration(
                                  labelText: 'Quantity',
                                  icon:
                                      Icon(Icons.format_list_numbered_rounded),
                                ),
                                // The validator receives the text that the user has entered.
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Mohon Masukan Jumlah';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        )),
                    actions: [
                      ElevatedButton(
                        child: Text("Tambahkan"),
                        // style: ButtonStyle(
                        //     backgroundColor:
                        //         MaterialStateProperty.all(Colors.purple)),
                        onPressed: (() {
                          if (_formKey.currentState!.validate()) {
                            postData({
                              //todo: Input Integer
                              "nama": inputNama.text,
                              "harga": inputHarga.text.toString(),
                              "quantity": inputQuantity.text.toString(),
                            });
                            inputNama.clear();
                            inputHarga.clear();
                            inputQuantity.clear();
                            Navigator.of(context).pop();
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text("Berhasil Ditambahkan"),
                                content: const Text("Silahkan Kembali"),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, "ok"),
                                    child: const Text("ok"),
                                  ),
                                ],
                              ),
                            );
                            // });
                          }
                        }),
                      )
                    ]);
              });
        },
        child: Icon(Icons.add),
      ),
      body: Container(child: DataApi()),
    );
  }
}

class PrintResponseBody extends StatelessWidget {
  const PrintResponseBody({super.key});

  Future<http.Response> getData() async {
    final response =
        await http.get(Uri.parse("http://${IPAdd}/api/produk/getAll"));
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class DataApi extends StatefulWidget {
  const DataApi({super.key});

  @override
  State<DataApi> createState() => _DataApiState();
}

class _DataApiState extends State<DataApi> {
  Future<http.Response> getData() async {
    final response =
        await http.get(Uri.parse("http://${IPAdd}/api/produk/getAll"));
    setState(() {
      response;
    });
    return response;
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final inputNama = TextEditingController();
    final inputHarga = TextEditingController();
    final inputQuantity = TextEditingController();

    return FutureBuilder(
      future: getData().then((value) => value.body),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<dynamic> json = jsonDecode(snapshot.data!);
          return ListView.builder(
            itemCount: json.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  child: Text("${json[index]["nama"][0]}"),
                ),
                title: Text("${json[index]["nama"]}"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(json[index]["harga"].toString()),
                    Text(json[index]["quantity"].toString()),
                  ],
                ),
                onTap: () {
                  print("Nama : ${json[index]["nama"]}");
                  print("Harga : ${json[index]["harga"].toString()}");
                  print("Quantity : ${json[index]["quantity"].toString()}");
                  print("Id : ${index + 1}");
                },
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit_rounded),
                      onPressed: () {
                        inputNama.text = json[index]["nama"];
                        inputHarga.text = json[index]["harga"].toString();
                        inputQuantity.text = json[index]["quantity"].toString();
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            scrollable: true,
                            content: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextFormField(
                                        controller: inputNama,
                                        decoration: const InputDecoration(
                                          labelText: 'Nama',
                                          icon:
                                              Icon(Icons.playlist_add_rounded),
                                        ),
                                        // The validator receives the text that the user has entered.
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Mohon Masukan Nama';
                                          }
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        controller: inputHarga,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: const InputDecoration(
                                          labelText: 'Harga',
                                          icon:
                                              Icon(Icons.price_change_rounded),
                                        ),
                                        // The validator receives the text that the user has entered.
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Mohon Masukan Harga';
                                          }
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        controller: inputQuantity,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: const InputDecoration(
                                          labelText: 'Quantity',
                                          icon: Icon(Icons
                                              .format_list_numbered_rounded),
                                        ),
                                        // The validator receives the text that the user has entered.
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Mohon Masukan Jumlah';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                )),
                            actions: [
                              ElevatedButton(
                                child: Text("Perbarui"),
                                // style: ButtonStyle(
                                //     backgroundColor:
                                //         MaterialStateProperty.all(Colors.purple)),
                                onPressed: (() {
                                  if (_formKey.currentState!.validate()) {
                                    updateData(json[index]["id"], {
                                      "nama": inputNama.text,
                                      "harga": inputHarga.text,
                                      "quantity": inputQuantity.text,
                                    });
                                    inputNama.clear();
                                    inputHarga.clear();
                                    inputQuantity.clear();
                                    Navigator.of(context).pop();
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: const Text(
                                            "Data Berhasil Diperbarui"),
                                        content: const Text("Silahkan kembali"),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, "ok"),
                                            child: const Text("ok"),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                }),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text("Menghapus data"),
                            content: const Text(
                                "Anda yakin ingin menghapus data ini!"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  deleteData(json[index][""]);
                                  Navigator.pop(context, "ok");
                                },
                                child: const Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: (() {
                                  setState(() {
                                    deleteData(json[index]["id"]);
                                    Navigator.pop(context, "ok");
                                  });
                                }),
                                child: const Text("ok"),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.delete_forever_rounded,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return Center(child: const CircularProgressIndicator());
      },
    );
  }
}

String IPAdd = "127.0.0.1:8082";

Future<http.Response> postData(Map<String, dynamic> data) async {
  final response =
      await http.post(Uri.parse("http://${IPAdd}/api/produk/insert"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(data));
  print(response.statusCode);
  print(response.body);
  return response;
}

Future<http.Response> updateData(int id, Map<String, dynamic> data) async {
  final response =
      await http.put(Uri.parse("http://${IPAdd}/api/produk/update/${id}"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(data));
  print(response.statusCode);
  print(response.body);
  return response;
}

Future<http.Response> deleteData(id) async {
  final response = await http.delete(
    Uri.parse("http://${IPAdd}/api/produk/delete/${id}"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  print(id);
  print(response.statusCode);
  print(response.body);
  return response;
}
