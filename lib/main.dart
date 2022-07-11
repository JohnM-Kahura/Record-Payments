import 'package:flutter/material.dart';
import 'package:record_payment/sheets_api.dart';

import 'home.dart';

Future  main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await UserSheetsApi.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Record Payments',
      debugShowCheckedModeBanner:false,
      theme: ThemeData(
        
        primarySwatch: Colors.yellow,
      ),
      home: const Home(),
      
    );
  }
}

