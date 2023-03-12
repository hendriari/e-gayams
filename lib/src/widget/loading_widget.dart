import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';
import 'package:loader_overlay/loader_overlay.dart';

Widget loadingOverlayWidget({
  required Widget child,
}) {
  return LoaderOverlay(
    useDefaultLoading: false,
    overlayWidget: Center(
      child: SpinKitThreeBounce(
        size: AdaptSize.screenWidth / 1000 * 130,
        color: MyColor.warning400,
      ),
    ),
    child: child,
  );
}

/// only spinkit loading
Widget spinKitLoading({
  Color? color,
  double? size,
}) {
  return SpinKitThreeBounce(
    size: size ?? AdaptSize.pixel16,
    color: color ?? MyColor.warning400,
  );
}
