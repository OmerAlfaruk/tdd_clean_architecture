import 'package:flutter/material.dart';
import 'package:tdd_tutorial/core/services/injection_container.dart';
import 'package:tdd_tutorial/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:tdd_tutorial/src/authentication/presentation/pages/home_screen.dart';
import "package:flutter_bloc/flutter_bloc.dart";
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthenticationCubit>(),
      child: MaterialApp(
        title: 'TDD Clean Architecture',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

