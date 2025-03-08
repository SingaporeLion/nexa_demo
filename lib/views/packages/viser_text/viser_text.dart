import 'package:flutter/material.dart';

class ViserText extends StatelessWidget {
  final String text;
  const ViserText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text.isNullOrEmpty);
  }
}

extension NullOrEmptyString on String {
  String get isNullOrEmpty {
    return this == null || this.isEmpty || this.trim().isEmpty || this == "null" ? "" : this;
  }
}
