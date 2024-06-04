import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laocaldatabase/dbservice.dart';
import 'package:laocaldatabase/screens/screen1.dart';
import 'package:laocaldatabase/screens/screen2.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await initial();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Screen2(),
    )
  );
}
