import 'package:flutter/material.dart';
import 'package:nexa/views/components/image/custom_svg_picture.dart';
import '../../../core/utils/my_color.dart';
import '../../../core/utils/my_images.dart';

class CircleImageWidget extends StatelessWidget {

  final double height;
  final double width;
  final String imagePath;
  final bool isAsset;
  final VoidCallback? press;
  final double border;
  final bool isProfile;

  const CircleImageWidget({
    super.key,
    this.isProfile = false,
    this.border=0,
    this.height=30,
    this.width=30,
    this.isAsset=true,
    required this.imagePath,
    this.press
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: border>0?ClipOval(
        child: Container(
          decoration: BoxDecoration(
            color: MyColor.transparentColor,
            border: Border.all(color: MyColor.colorGrey2,width: 1),
          ),
          child: FadeInImage.assetNetwork(
            image: imagePath,
            fit: BoxFit.cover,
            width: height,
            height: width,
            imageErrorBuilder: (ctx,object,trx){
              return Image.asset(
                isProfile?MyImages.person:MyImages.placeHolderImage,
                fit: BoxFit.cover,
                width: height,
                height: width,
              );
            }, placeholder: isProfile?MyImages.person:MyImages.placeHolderImage,
          ),
        ),
      ):imagePath.contains('svg')?CustomSvgPicture(image:
        imagePath,
        fit: BoxFit.cover,
        width: height,
        height: width,
      ):ClipOval(
          child: isAsset?Image.asset(
            imagePath,
            fit: BoxFit.cover,
            width: height,
            height: width,
          ):ClipOval(
            child: FadeInImage.assetNetwork(
              image: imagePath,
              fit: BoxFit.cover,
              width: height,
              height: width,
              imageErrorBuilder: (ctx,object,trx){
                return Image.asset(
                  isProfile?MyImages.person:MyImages.placeHolderImage,
                  fit: BoxFit.cover,
                  width: height,
                  height: width,
                );
              },
              placeholder: isProfile?MyImages.person:MyImages.placeHolderImage,
            ),
          )
      ),
    );
  }
}
