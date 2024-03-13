import 'package:asmaul_husna_guide/models/asmahus_model.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String _baseUrl = 'https://asmaul-husna-api.vercel.app/api/all';

  Future<List<Data>> getAsmaulHusna() async {
    var response = await http.get(Uri.parse(_baseUrl));

    List<dynamic> data =
        (jsonDecode(response.body) as Map<String, dynamic>)['data'];

    List<Data> allData = [];
    for (var element in data) {
      allData.add(
        Data.fromJson(element),
      );
    }
    return allData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Asmaul Husna Guide'),
      ),
      body: FutureBuilder(
        future: getAsmaulHusna(),
        builder: (context, AsyncSnapshot<List<Data>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Terjadi Error'),
            );
          } else {
            List<Data>? allData = snapshot.data;
            return GridView.builder(
              itemCount: allData!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(10),
                child: Card(
                  color: Colors.amber,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(200),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            allData[index].latin!,
                            textAlign: TextAlign.center, // Latin text
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            allData[index].arab!,
                            textAlign: TextAlign.center, // Arabic text
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 38,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            allData[index].arti!,
                            textAlign: TextAlign.center, // Meaning
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
