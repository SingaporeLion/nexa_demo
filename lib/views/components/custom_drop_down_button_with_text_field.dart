import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/styles.dart';

class CustomDropDownWithTextField extends StatefulWidget {
  final String? title, selectedValue;
  final List<String>? list;
  final ValueChanged? onChanged;
  TextStyle? selectedTextStyle;
  TextStyle? itemTextStyle;

  CustomDropDownWithTextField({
    super.key,
    this.title,
    this.selectedValue,
    this.list,
    this.onChanged,
    this.itemTextStyle,
    this.selectedTextStyle,
  }) : assert(list != null && list.contains(selectedValue), "Selected value must be from the list & list can't be empty");

  @override
  State<CustomDropDownWithTextField> createState() => _CustomDropDownWithTextFieldState();
}

class _CustomDropDownWithTextFieldState extends State<CustomDropDownWithTextField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.list?.removeWhere((element) => element.isEmpty);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 45,
          decoration: BoxDecoration(color: MyColor.transparentColor, borderRadius: const BorderRadius.all(Radius.circular(5)), border: Border.all(color: MyColor.getTextFieldDisableBorder())),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
            child: DropdownButton(
              isExpanded: true,
              underline: Container(),
              hint: Text(
                widget.selectedValue?.tr ?? '',
                style: widget.selectedTextStyle ?? interRegularDefault.copyWith(color: MyColor.colorBlack),
              ), // Not necessary for Option 1
              value: widget.selectedValue,
              dropdownColor: MyColor.colorWhite,
              onChanged: widget.onChanged,
              items: widget.list!.map(
                (value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Row(
                      children: [
                        Text(
                          value.tr,
                          style: widget.itemTextStyle ?? interRegularDefault.copyWith(color: MyColor.colorBlack),
                        ),
                      ],
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
