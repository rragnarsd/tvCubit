import 'package:flutter/material.dart';

class ShowProgressIndicator extends StatelessWidget {
  const ShowProgressIndicator({
    Key? key,
    required this.progress,
  }) : super(key: key);

  final Animation<double>? progress;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -80,
      child: FadeTransition(
        opacity: progress!,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.88,
          alignment: Alignment.topCenter,
          child: LinearProgressIndicator(
            value: 0.7,
            backgroundColor: Colors.white.withOpacity(0.5),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xffE7A71A)),
          ),
        ),
      ),
    );
  }
}