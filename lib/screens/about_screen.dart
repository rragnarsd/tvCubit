import 'package:flutter/material.dart';
import 'package:tv_cubit/models/tv.dart';

class TvShow {
  final String name;
  final String country;
  final String iamgeUrl;

  TvShow({required this.name, required this.country, required this.iamgeUrl});
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key, required this.tvModel}) : super(key: key);

  final TvModel tvModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Text(tvModel.name),
        Image.network(tvModel.imageUrl,
            errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.red,
            child: LayoutBuilder(
              builder: (context, constraints) => const Icon(
                Icons.error,
                color: Colors.white,
              ),
            ),
          );
        }),
      ],
    ));
  }
}
