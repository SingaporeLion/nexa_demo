import 'package:flutter/material.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/my_images.dart';
import 'package:nexa/core/utils/styles.dart';

class MinerCardItem extends StatefulWidget {
  final String image;
  final String title;
  final String data;
  final bool isNetWorkImage;

  const MinerCardItem({
    Key? key,
    required this.image,
    required this.title,
    required this.data,
    this.isNetWorkImage = false
  }) : super(key: key);

  @override
  State<MinerCardItem> createState() => _MinerCardItemState();
}

class _MinerCardItemState extends State<MinerCardItem> {
  bool hasError = false;

  @override
  Widget build(BuildContext context) {
    return !hasError ? Container(
      padding: const EdgeInsets.symmetric(
          vertical: Dimensions.space15, horizontal: Dimensions.space15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: MyColor.colorWhite,
        borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 30, width: 30,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: widget.isNetWorkImage ? DecorationImage(
                    image: NetworkImage(widget.image
                    ),
                    fit: BoxFit.fill,
                    onError: (Object e, StackTrace? stackTrace) {
                      setState(() {
                        hasError = true;
                      });
                    }
                ) : DecorationImage(
                  image: AssetImage(widget.image),
                  fit: BoxFit.fill,
                )
            ),
          ),
          const SizedBox(width: Dimensions.space15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(widget.title, style: interRegularDefault.copyWith(
                  fontWeight: FontWeight.w500)),
              const SizedBox(height: Dimensions.space5),
              Text(widget.data, style: interRegularLarge.copyWith(
                  fontWeight: FontWeight.w600), maxLines: 2),
            ],
          )
        ],
      ),
    ) : Container(
      padding: const EdgeInsets.symmetric(
          vertical: Dimensions.space15, horizontal: Dimensions.space15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: MyColor.colorWhite,
        borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 30, width: 30,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image:  DecorationImage(
                  image: AssetImage(MyImages.errorImage),
                  fit: BoxFit.fill,
                )
            ),
          ),
          const SizedBox(width: Dimensions.space15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(widget.title, style: interRegularDefault.copyWith(
                  fontWeight: FontWeight.w500)),
              const SizedBox(height: Dimensions.space5),
              Text(widget.data, style: interRegularLarge.copyWith(
                  fontWeight: FontWeight.w600), maxLines: 2),
            ],
          )
        ],
      )
      ,
    );
  }
}
