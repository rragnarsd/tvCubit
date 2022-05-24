import 'package:flutter/material.dart';

class ShowImage extends StatelessWidget {
  const ShowImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: ShaderMask(
        shaderCallback: (rect) {
          return const LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff211F1C),
                Colors.transparent,
              ]).createShader(
            Rect.fromLTRB(0, 0, rect.width, rect.height),
          );
        },
        blendMode: BlendMode.dstIn,
        child: Image.network(
          'https://browsecat.net/sites/default/files/vis-a-vis-wallpapers-87509-978456-5904185.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}