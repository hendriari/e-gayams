import 'package:flutter/material.dart';

Future modalBottomSheed({
  required BuildContext context,
  required Widget child,
}) {
  return showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    ),
    isScrollControlled: true,
    context: context,
    builder: (context) => child,
  );
}
