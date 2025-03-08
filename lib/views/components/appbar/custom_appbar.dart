import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/route/route.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/styles.dart';
import 'package:nexa/data/services/api_service.dart';
import 'package:nexa/views/components/dialog/exit_dialog.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget{
  final String title;
  final bool isShowBackBtn;
  final Color bgColor;
  final bool isShowActionBtn;
  final bool isTitleCenter;
  final bool fromAuth;
    final List<Widget>? action;
  final bool isProfileCompleted;

  const CustomAppBar({Key? key,
    this.isProfileCompleted=false,
    this.fromAuth = false,
    this.isTitleCenter = false,
    this.bgColor = Colors.transparent,
    this.isShowBackBtn=true,
    required this.title,
       this.action,
    this.isShowActionBtn=false}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size(double.maxFinite, 50);
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool hasNotification =false;
  @override
  void initState() {
   Get.put(ApiClient(sharedPreferences: Get.find()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isShowBackBtn?AppBar(
      elevation: 0,
      leading:widget.isShowBackBtn? IconButton(onPressed: (){
        if(widget.fromAuth){
          Get.offAllNamed(RouteHelper.loginScreen);
        }else if(widget.isProfileCompleted){
          showExitDialog(context);
        }
        else{
          String previousRoute=Get.previousRoute;
          if(previousRoute==RouteHelper.splashScreen){
            Get.offAndToNamed(RouteHelper.homeScreen);
          }else{
            Get.back();
          }
        }
      },icon: const Icon(Icons.arrow_back,color: MyColor.colorWhite, size: 20)):const SizedBox.shrink(),
      backgroundColor: widget.bgColor,
      title: Text(widget.title,style: interRegularLarge.copyWith(color: MyColor.colorWhite)),
      centerTitle: widget.isTitleCenter,
      actions: widget.action,
    ):AppBar(
      elevation: 0,
      backgroundColor: widget.bgColor,
      title:Text(widget.title,style: interRegularLarge.copyWith(color: MyColor.colorWhite)),
      automaticallyImplyLeading: false,
      actions: widget.action,
    );
  }


}
