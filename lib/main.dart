import 'package:flutter/material.dart';
import 'widgets/DataTable/DataTableDemo.dart';
void main() {
  runApp(new HomeApp());
}
class HomeApp extends StatelessWidget {
  const HomeApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter Mysql",
      home: new DataTableDemo(),
    );
  }
}
