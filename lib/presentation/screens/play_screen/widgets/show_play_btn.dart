import 'package:flutter/material.dart';
import 'package:tv_cubit/presentation/shared/widgets/btn_with_extra_border.dart';

class PlayShowBtn extends StatelessWidget {
  const PlayShowBtn({
    Key? key,
    required this.button,
  }) : super(key: key);

  final Animation<double>? button;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -200,
      left: 25,
      child: FadeTransition(
        opacity: button!,
        child: const BtnWithExtraBorder(
          btnText: 'Continue Watch',
        ),
      ),
    );
  }
}
