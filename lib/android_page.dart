import 'package:flutter/material.dart';

class AndroidPage extends StatefulWidget {
  const AndroidPage({Key? key}) : super(key: key);

  @override
  AndroidPageState createState() => AndroidPageState();
}

class AndroidPageState extends State<AndroidPage> {
  bool loveIt = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notre design sous Android"),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: (() {
                setState(() {
                  loveIt = !loveIt;
                });
              }),
              child: Text(loveIt ? "I love flutter" : "I prefer swiftUI"))
        ],
      ),
    );
  }
}
