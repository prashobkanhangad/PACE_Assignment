import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pace/controller/getcontroller.dart';
import 'package:pace/core/constants.dart';
import 'package:pace/db/model.dart';
import 'package:pace/presentation/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(NewsmodelAdapter());

  Get.put(Newscontroller()).fetchdata();
  Get.put(Newscontroller()).getnewsdata();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: kScaffoldbackgroundcolor,
        primarySwatch: Colors.blue,
      ),
      home: Homepage(),
    );
  }
}
