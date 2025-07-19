import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qaviews/utils/app_theme.dart';

class CategoryWidget extends StatelessWidget {
  final String imageURL, title;
  final Function onClick;

  CategoryWidget(this.imageURL, this.title, this.onClick);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 58,
          height: 58,
          decoration:
              BoxDecoration(shape: BoxShape.circle,
                  color: Colors.white,
              ),
          child: Center(
            child: SvgPicture.asset(imageURL),
          ),
        ),
        SizedBox(height: 8),
        Center(
          child: Container(
            child: Text(title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
                maxLines: 2),
          ),
        ),
      ],
    );
  }
}

class CategoryAssetWidget extends StatelessWidget {
  final String imageURL, title;
  final Function onClick;

  CategoryAssetWidget(this.imageURL, this.title, this.onClick);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 58,
          height: 58,
          decoration:
          BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          child: Center(
            child: SvgPicture.asset(imageURL,width: 28,height: 28),
          ),
        ),
        SizedBox(height: 8),
        Center(
          child: Container(
            child: Text(title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
                maxLines: 2),
          ),
        ),
      ],
    );
  }
}



class BrandsWidget extends StatelessWidget {
  final String imageURL;
  final Function onClick;

  BrandsWidget(this.imageURL, this.onClick);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      height: 58,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
      child: Center(
        child: Image.network(
          imageURL,
          width: 35,
          height: 35,
        ),
      ),
    );
  }
}

class BottomWidget extends StatelessWidget {
  final String imageURL, title;
  final Function onClick;

  BottomWidget(this.imageURL, this.title, this.onClick);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onClick();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 55,
            height: 55,
            child: Center(
              child: SvgPicture.asset(imageURL,color: AppTheme.themeColor),
            ),
          ),
          SizedBox(height: 8),
          Center(
            child: Container(
              width: 100,
              child: Text(title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2),
            ),
          ),
        ],
      ),
    );
  }
}
