import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class BtnWithExtraBorder extends StatelessWidget {
  const BtnWithExtraBorder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBoxShadow,
      child: Stack(clipBehavior: Clip.none, children: [
        Positioned(
          bottom: -12 / 2,
          right: -12 / 2,
          child: Container(
            height: 40,
            width: MediaQuery.of(context).size.width * 0.80,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white24, width: 1.2),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.88,
          height: 45,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {},
            child: Text(
              'Watch',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Colors.white.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1),
            ),
          ),
        ),
      ]),
    );
  }
}
