import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/device_viewmodel.dart';
import 'views/device_grid_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DeviceViewModel(),
      child: MaterialApp(
        title: 'Device Store',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const DeviceGridView(),
      ),
    );
  }
}