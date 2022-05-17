import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'glassmorphism.dart';

class Appbar extends StatelessWidget {
  const Appbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: Color(0xffC18E69),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello,',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                  const Text(
                    'Regina',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          GlassMorphism(
            blur: 20,
            opacity: 1,
            radius: BorderRadius.circular(12.0),
            border: Border.all(
              width: 1.5,
              color: Colors.brown.withOpacity(0.2),
            ),
            child: SizedBox(
              width: 40,
              height: 40,
              child: Center(
                child: FaIcon(
                  FontAwesomeIcons.bell,
                  size: 18.0,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}