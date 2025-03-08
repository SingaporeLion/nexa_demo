import 'package:flutter/material.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/styles.dart';
import 'package:nexa/views/components/text/label_text.dart';

class CustomAmountTextField extends StatefulWidget {
  const CustomAmountTextField({Key? key, required this.labelText, required this.hintText, required this.currency, this.autoFocus = false, required this.onChanged, this.controller, this.inputAction, this.readOnly = false}) : super(key: key);

  final String currency;
  final String labelText;
  final String hintText;
  final bool autoFocus;
  final Function(String) onChanged;
  final TextEditingController? controller;
  final TextInputAction? inputAction;
  final bool readOnly;

  @override
  State<CustomAmountTextField> createState() => _CustomAmountTextFieldState();
}

class _CustomAmountTextFieldState extends State<CustomAmountTextField> {
  bool isFocus = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelText(text: widget.labelText),
        const SizedBox(height: 8),
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: 8),
          decoration: BoxDecoration(color: MyColor.transparentColor, border: Border.all(color: isFocus ? MyColor.primaryColor : MyColor.lineColor, width: 1.00), borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 5,
                child: FocusScope(
                  child: Focus(
                    onFocusChange: (focus) {
                      setState(() {
                        isFocus = focus;
                      });
                    },
                    child: TextField(
                      readOnly: widget.readOnly,
                      cursorColor: MyColor.colorBlack,
                      controller: widget.controller,
                      autofocus: widget.autoFocus,
                      style: interRegularDefault.copyWith(color: MyColor.colorBlack),
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.number,
                      textInputAction: widget.inputAction,
                      onChanged: widget.onChanged,
                      decoration:
                          InputDecoration(contentPadding: const EdgeInsets.only(bottom: 16), hintText: widget.hintText, hintStyle: interRegularSmall.copyWith(color: MyColor.hintTextColor, height: 1.452), border: InputBorder.none, focusedBorder: InputBorder.none, enabledBorder: InputBorder.none, disabledBorder: InputBorder.none, focusedErrorBorder: InputBorder.none, errorBorder: InputBorder.none),
                    ),
                  ),
                ),
              ),
              Container(
                width: 48,
                padding: const EdgeInsets.all(Dimensions.space5),
                decoration: BoxDecoration(color: MyColor.colorBlack.withValues(alpha: 0.04), borderRadius: BorderRadius.circular(5)),
                alignment: Alignment.center,
                child: Text(widget.currency, textAlign: TextAlign.center, style: interRegularDefault.copyWith(color: MyColor.primaryColor, fontWeight: FontWeight.w500)),
              )
            ],
          ),
        ),
      ],
    );
  }
}
