import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final name;
  final pic;
  const DetailsPage({Key? key, required this.name, required this.pic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Details Page"), centerTitle: true),

      body: Column(
        children: [
           Image.network(pic),
            Text(name.toString()),
        ],
      ),
    );
  }
}
