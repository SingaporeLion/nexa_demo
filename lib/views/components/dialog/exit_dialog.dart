import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/core/utils/styles.dart';
import 'package:nexa/views/components/buttons/rounded_button.dart';

  showExitDialog(BuildContext context){

    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      dialogBackgroundColor: MyColor.colorWhite,
      width: 300,
      buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: true,
      onDismissCallback: (type) {},
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: MyStrings.exitTitle,
      titleTextStyle:interRegularDefault.copyWith(color: MyColor.colorBlack,fontSize: Dimensions.fontLarge,fontWeight: FontWeight.w500),
      showCloseIcon: false,
      btnCancel: RoundedButton(
          text: MyStrings.no,
          press: (){
            Navigator.pop(context);
          },
          horizontalPadding: 3,
          verticalPadding: 3,
          color: MyColor.screenBgColor,
          textColor: MyColor.colorBlack
      ),
      btnOk: RoundedButton(
          text: MyStrings.yes,
          press: (){
            SystemNavigator.pop();
          },
          horizontalPadding: 3,
          verticalPadding: 3,
          color: MyColor.colorRed
      ),
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        SystemNavigator.pop();
      },
    ).show();
  }
