import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IOSPage extends StatefulWidget {
  const IOSPage({Key? key}) : super(key: key);

  @override
  IOSPageState createState() => IOSPageState();
}

class IOSPageState extends State<IOSPage> {
  bool loveIt = true;
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text("Design sous iOS"),
          leading: Icon(Icons.source),
          backgroundColor: Colors.red,
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // mainAxisSize: MainAxisSize.max,
          children: [
            CupertinoButton(
                color: Colors.lightBlueAccent,
                child: Text(loveIt ? "I love flutter" : "I prefer swiftUI"),
                onPressed: () {
                  setState(() {
                    loveIt = !loveIt;
                  });
                })
          ],
        ));
  }
}
