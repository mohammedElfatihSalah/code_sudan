import 'package:app_inter_2/home/widgets/home_sizes.dart';
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
            height: HomeSizes.ITEM_HEIGHT,
            width: HomeSizes.ITEM_HEIGHT,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    offset: Offset(8, 8),
                    blurRadius: 5),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    height: 180,
                    width: 180,
                    image: AssetImage(imageUrl),
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  bottom: 10,
                  child: Text(
                    name,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
