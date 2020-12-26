import 'package:app_inter_2/home/widgets/home_sizes.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
          child: Image(
            height: HomeSizes.APPBAR_HEIGHT,
            image: AssetImage(
              'assets/home_back_2.png',
            ),
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          top: 32,
          right: 32,
          child: Text(
            'Programming \n path',
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.white,
                fontSize: 35,
                fontFamily: 'LuckiestGuy-Regular'),
          ),
        )
      ],
    );
  }
}
