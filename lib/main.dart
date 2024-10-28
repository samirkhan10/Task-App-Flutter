import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/Controller/TaskController.dart';
import 'Exports/MyExports.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Taskcontroller()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WebReinvent Task ',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MySplashScreen(),
      ),
    );
  }
}


// sudo chmod u+rwx /Users/samirkhan/Downloads/flutter/sdk

// sudo chmod -R u+w /Users/samirkhan/Documents/flutter
