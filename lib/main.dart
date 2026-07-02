import 'package:flutter/material.dart';
import 'package:tabungan_frontend/features/dashboard/dashboard_screen.dart';
import 'package:tabungan_frontend/core/repositories/transaction_repository.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  await TransactionRepository().init();
  
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tabungan Online',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0F766E)), // Deep Emerald Green
        useMaterial3: true,
      ),
      home: const DashboardScreen(),
    );
  }
}
