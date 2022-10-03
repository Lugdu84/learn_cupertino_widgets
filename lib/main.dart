import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_cupertino_widgets/adaptive_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;
    bool isOS = (platform == TargetPlatform.iOS);
    return isOS ? iOSBase(platform: platform) : androidBase(platform: platform);
  }

  CupertinoApp iOSBase({required TargetPlatform platform}) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: const CupertinoThemeData(primaryColor: Colors.green),
      title: "Learn Cupertino",
      home: AdaptivePage(
        platform: platform,
      ),
    );
  }

  MaterialApp androidBase({required TargetPlatform platform}) {
    return MaterialApp(
      title: 'Learn Cupertino',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: AdaptivePage(
        platform: platform,
      ),
    );
  }
}
