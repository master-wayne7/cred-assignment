import 'package:cred/cubit/section_layout_cubit.dart';
import 'package:cred/cubit/selected_item_cubit.dart';
import 'package:cred/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/category_bloc.dart';
import 'pages/home_page.dart';
import 'repositories/category_repository.dart';

// Global variables
double height = 0;
double width = 0;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  /// Root APP
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // registering bloc
      providers: [
        BlocProvider(
          create: (context) => CategoryBloc(CategoryRepository()),
        ),
        BlocProvider(
          create: (context) => SectionLayoutCubit(),
        ),
        BlocProvider(
          create: (context) => SelectedItemCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(useMaterial3: true),
        title: 'CRED',
        home: const SplashPage(),
      ),
    );
  }
}
