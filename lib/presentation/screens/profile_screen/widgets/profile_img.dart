import 'package:flutter/material.dart';
import 'package:tv_cubit/presentation/shared/widgets/fade_in_img.dart';

class ProfileImg extends StatelessWidget {
  const ProfileImg({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: FadeInImg(
        imgUrl:
            'https://images.pexels.com/photos/1188750/pexels-photo-1188750.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
      ),
    );
  }
}
