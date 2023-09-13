// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/viewdata.dart';
void main(){
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  void initState(){
    super.initState();
    getApi();
  }
  late List<dynamic> data;
  
  Future<String> getApi() async{
    var jsondata = await http.get(Uri.parse("https://newsapi.org/v2/top-headlines?country=in&category=entertainment&apiKey=c1f36727d4a847b9b85b6e82b0484436"));
    var jsondec = jsonDecode(jsondata.body);
    setState(() {
      data = jsondec['articles'];
    });
    return "success";
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(),
        body: ListView.builder(
          itemCount: data==null?0:data.length,
          itemBuilder: (context, index) {
            var article = data[index];
          return InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ViewData(article: article),));
            },
            child: Card(
              elevation: 5,
              margin: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Column(
                  children: [
                    Image.network(data[index]['urlToImage'].toString()),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(data[index]['title'].toString()),
                    ),
                  ],
                ),
              ),
            ),
          );
        },),
      ),
    );
  }
}
