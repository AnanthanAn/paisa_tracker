import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paisa_tracker/model/player.dart';
import 'package:paisa_tracker/view/home_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'model/transaction.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PlayerAdapter());
  Hive.registerAdapter(TransactionAdapter());
  await Hive.openBox<Player>('players');
  await Hive.openBox<Transaction>('transactions');
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(theme: ThemeData(textTheme: GoogleFonts.latoTextTheme()),
      home: HomePage(),
    );
  }
}
