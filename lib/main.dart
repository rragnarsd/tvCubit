import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_cubit/data/repositories/tv_repository.dart';
import 'package:tv_cubit/presentation/shared/widgets/bottom_bar.dart';
import 'package:tv_cubit/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0XFF636260),
        statusBarBrightness: Brightness.dark,
      ),
    );
    return RepositoryProvider(
      create: (context) => TvRepository(),
      child: MaterialApp(
        title: 'Tv Cubit',
        debugShowCheckedModeBanner: false,
        theme: CustomTheme.lightTheme,
        home: const BottomBar(),
      ),
    );
  }
}
