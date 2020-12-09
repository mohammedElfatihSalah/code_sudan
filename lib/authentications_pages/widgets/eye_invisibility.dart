import 'package:flutter/material.dart';

class EyeInvisibility extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          child: Icon(
            Icons.remove_red_eye,
            color: Colors.black,
          ),
        ),
        Transform.rotate(
          angle: 3.14 / 180 * 30,
          child: Container(
              color: Colors.black,
              child: SizedBox(
                height: 25,
                width: 3,
              )),
        )
      ],
    );
  }
}
