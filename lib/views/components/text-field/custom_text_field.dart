import 'package:flutter/material.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/styles.dart';
import 'package:nexa/views/components/text/label_text.dart';
import 'package:nexa/views/components/text/label_text_with_instructions.dart';

class CustomTextField extends StatefulWidget {
  final String? instructions;
  final String? initialValue;
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
  final bool isRequired;
  final int? maxLines;
  final double radius;

  const CustomTextField(
      {Key? key,
      this.labelText,
      this.instructions,
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
      this.maxLines,
      this.initialValue,
      this.radius = Dimensions.largeRadius,
      this.isRequired = false})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return widget.needOutlineBorder
        ? widget.needLabel
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabelTextInstruction(
                    text: widget.labelText.toString(),
                    isRequired: widget.isRequired,
                    instructions: widget.instructions,
                  ),
                  TextFormField(
                    maxLines: widget.maxLines ?? 1,
                    readOnly: widget.readOnly,
                    style: interRegularDefault.copyWith(color: MyColor.colorBlack),
                    textAlign: TextAlign.left,
                    cursorColor: MyColor.colorBlack,
                    controller: widget.controller,
                    autofocus: false,
                    textInputAction: widget.inputAction,
                    enabled: widget.isEnable,
                    initialValue: widget.initialValue,
                    focusNode: widget.focusNode,
                    validator: widget.validator,
                    keyboardType: widget.textInputType,
                    obscureText: widget.isPassword ? obscureText : false,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(top: Dimensions.space5, left: Dimensions.space15, right: Dimensions.space15, bottom: Dimensions.space5),
                      hintText: widget.hintText,
                      hintStyle: interRegularSmall.copyWith(color: MyColor.hintTextColor),
                      fillColor: MyColor.transparentColor,
                      filled: true,
                      border: OutlineInputBorder(borderSide: const BorderSide(color: MyColor.colorGrey), borderRadius: BorderRadius.circular(widget.radius)),
                      focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: MyColor.primaryColor), borderRadius: BorderRadius.circular(widget.radius)),
                      enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: MyColor.screenBgColor), borderRadius: BorderRadius.circular(widget.radius)),
                      prefixIcon: widget.isShowPrefixIcon
                          ? Padding(
                              padding: const EdgeInsets.only(left: Dimensions.space10, right: Dimensions.space10),
                              child: Image.asset(widget.prefixIconUrl.toString(), color: MyColor.primarySubTitleColor, height: 16, width: 16),
                            )
                          : const SizedBox(),
                      prefixIconConstraints: const BoxConstraints(minWidth: 23, maxHeight: 20),
                      suffixIcon: widget.isShowSuffixIcon
                          ? widget.isPassword
                              ? IconButton(icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility, color: MyColor.hintTextColor, size: 20), onPressed: _toggle)
                              : widget.isIcon
                                  ? IconButton(
                                      onPressed: widget.onSuffixTap,
                                      icon: Icon(
                                        widget.isSearch
                                            ? Icons.search_outlined
                                            : widget.isCountryPicker
                                                ? Icons.arrow_drop_down_outlined
                                                : Icons.camera_alt_outlined,
                                        size: 25,
                                        color: MyColor.primaryColor,
                                      ),
                                    )
                                  : null
                          : null,
                    ),
                    onFieldSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus) : null,
                    onChanged: (text) => widget.onChanged!(text),
                    onTap: widget.onTap,
                  )
                ],
              )
            : TextFormField(
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
                obscureText: widget.isPassword ? obscureText : false,
                decoration: InputDecoration(
                  labelText: widget.labelText,
                  labelStyle: interRegularDefault.copyWith(color: MyColor.textFieldLabelColor),
                  hintText: widget.hintText,
                  hintStyle: interRegularSmall.copyWith(color: MyColor.hintTextColor),
                  fillColor: MyColor.transparentColor,
                  filled: true,
                  border: OutlineInputBorder(borderSide: BorderSide(color: MyColor.lineColor), borderRadius: BorderRadius.circular(widget.radius)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: MyColor.primaryColor), borderRadius: BorderRadius.circular(widget.radius)),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: MyColor.lineColor), borderRadius: BorderRadius.circular(widget.radius)),
                  prefixIconConstraints: const BoxConstraints(minWidth: 23, maxHeight: 20),
                  prefixIcon: widget.isShowPrefixIcon
                      ? Padding(
                          padding: const EdgeInsets.only(left: Dimensions.space20, right: Dimensions.space5),
                          // child: Image.asset(widget.prefixIconUrl),
                          child: Image.asset(widget.prefixIconUrl.toString(), color: MyColor.primarySubTitleColor, height: 16, width: 16),
                        )
                      : const SizedBox.shrink(),
                  suffixIcon: widget.isShowSuffixIcon
                      ? widget.isPassword
                          ? IconButton(icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility, color: MyColor.hintTextColor, size: 20), onPressed: _toggle)
                          : widget.isIcon
                              ? IconButton(
                                  onPressed: widget.onSuffixTap,
                                  icon: Icon(
                                    widget.isSearch
                                        ? Icons.search_outlined
                                        : widget.isCountryPicker
                                            ? Icons.arrow_drop_down_outlined
                                            : Icons.camera_alt_outlined,
                                    size: 25,
                                    color: MyColor.primaryColor,
                                  ),
                                )
                              : null
                      : null,
                ),
                onFieldSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus) : null,
                onChanged: (text) => widget.onChanged!(text),
                onTap: widget.onTap,
              )
        : TextFormField(
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
            obscureText: widget.isPassword ? obscureText : false,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(top: 5, left: 0, right: 0, bottom: 5),
              labelText: widget.labelText,
              labelStyle: interRegularDefault.copyWith(color: MyColor.textFieldLabelColor),
              fillColor: MyColor.transparentColor,
              filled: true,
              border: const UnderlineInputBorder(borderSide: BorderSide(color: MyColor.colorGrey)),
              focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: MyColor.primaryColor)),
              enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: MyColor.colorGrey)),
              prefixIconConstraints: const BoxConstraints(minWidth: 23, maxHeight: 20),
              prefixIcon: widget.isShowPrefixIcon
                  ? Padding(
                      padding: const EdgeInsets.only(left: Dimensions.space20, right: Dimensions.space5),
                      // child: Image.asset(widget.prefixIconUrl),
                      child: Image.asset(widget.prefixIconUrl.toString(), color: MyColor.primarySubTitleColor, height: 16, width: 16),
                    )
                  : const SizedBox.shrink(),
              suffixIcon: widget.isShowSuffixIcon
                  ? widget.isPassword
                      ? IconButton(icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility, color: MyColor.hintTextColor, size: 20), onPressed: _toggle)
                      : widget.isIcon
                          ? IconButton(
                              onPressed: widget.onSuffixTap,
                              icon: Icon(
                                widget.isSearch
                                    ? Icons.search_outlined
                                    : widget.isCountryPicker
                                        ? Icons.arrow_drop_down_outlined
                                        : Icons.camera_alt_outlined,
                                size: 25,
                                color: MyColor.primaryColor,
                              ),
                            )
                          : null
                  : null,
            ),
            onFieldSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus) : null,
            onChanged: (text) => widget.onChanged!(text),
            onTap: widget.onTap,
          );
  }

  void _toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}
