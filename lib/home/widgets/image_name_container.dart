import 'package:flutter/material.dart';

class ImageNameContainer extends StatelessWidget {
  final String imageUrl;
  final String name;
  final Function onPressed;

  const ImageNameContainer({Key key, this.imageUrl, this.name, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  offset: Offset(8, 8),
                  blurRadius: 5),
            ]),
            child: Image(
              image: AssetImage(imageUrl),
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            name,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
