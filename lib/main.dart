import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:testing/table/table.dart';
import 'package:testing/sidebar/widget/sidebar_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  static const String title = 'Navigation Drawer';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        fontFamily: 'Poppins', // Set the default font family to Poppins
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Set the main background to greyish white
      body: Row(
        children: [
          const SidebarWidget(),
          Expanded(
            child: Container(
              color: Colors.white,
              child: const TableTesting(title: 'Leads'),
            ),
          ),
        ],
      ),
    );
  }
}