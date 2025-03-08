import 'package:flutter/material.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/styles.dart';
import 'package:nexa/views/components/text/label_text.dart';

class OutlinedTextField extends StatefulWidget {

  //this text field only use for all of bottom sheet section

  final String? labelText;
  final String? hintText;
  final Function? onChanged;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final FormFieldValidator? validator;
  final TextInputType? textInputType;
  final bool isEnable;
  final bool isPassword;
  final bool isShowSuffixIcon;
  final bool isIcon;
  final VoidCallback? onSuffixTap;
  final bool isSearch;
  final bool isCountryPicker;
  final TextInputAction inputAction;
  final bool needOutlineBorder;
  final bool needLabel;
  final bool readOnly;
  final bool isShowPrefixIcon;
  final String? prefixIconUrl;
  final VoidCallback? onTap;

  const OutlinedTextField({
    Key? key,
    this.labelText,
    this.readOnly = false,
    required this.onChanged,
    this.hintText,
    this.controller,
    this.focusNode,
    this.nextFocus,
    this.validator,
    this.textInputType,
    this.isEnable = true,
    this.isPassword = false,
    this.isShowSuffixIcon = false,
    this.isIcon = false,
    this.onSuffixTap,
    this.isSearch = false,
    this.isCountryPicker = false,
    this.inputAction = TextInputAction.next,
    this.needOutlineBorder = false,
    this.needLabel = true,
    this.isShowPrefixIcon = false,
    this.prefixIconUrl,
    this.onTap,
  }) : super(key: key);

  @override
  State<OutlinedTextField> createState() => _OutlinedTextFieldState();
}

class _OutlinedTextFieldState extends State<OutlinedTextField> {

  bool obscureText = true;

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelText(text: widget.labelText.toString(), textColor: MyColor.labelTextColor),
        const SizedBox(height: Dimensions.textToTextSpace),
        TextFormField(
          readOnly: widget.readOnly,
          style: interRegularDefault,
          textAlign: TextAlign.left,
          cursorColor: MyColor.colorBlack,
          controller: widget.controller,
          autofocus: false,
          textInputAction: widget.inputAction,
          enabled: widget.isEnable,
          focusNode: widget.focusNode,
          validator: widget.validator,
          keyboardType: widget.textInputType,
          obscureText: widget.isPassword?obscureText:false,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 5, left: Dimensions.space15, right: Dimensions.space15, bottom: 5),
            hintText: widget.hintText,
            hintStyle: interRegularSmall.copyWith(color: MyColor.hintTextColor),
            fillColor: MyColor.transparentColor,
            //filled: true,
            border: const OutlineInputBorder(borderSide: BorderSide(color: MyColor.lineColor)),
            focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: MyColor.primaryColor)),
            enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: MyColor.lineColor))),
          onFieldSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus) : null,
          onChanged: (text)=> widget.onChanged!(text),
          onTap: widget.onTap,
        ),
      ],
    );
  }

  void _toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}