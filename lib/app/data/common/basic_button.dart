import 'package:flutter/material.dart';
import 'package:tabee3_flutter/app/data/common/constants.dart';

// ignore: must_be_immutable
class BasicButton extends StatelessWidget {
  final label;
  Function()? onPresed;
  double? verticalPadding;
  double? horzentalPadding;
  double? fontSize;
  double? raduis;
  final bool outline;
  final bool border;
  final Color buttonColor;

  BasicButton({
    Key? key,
    this.label,
    this.onPresed,
    this.verticalPadding,
    this.horzentalPadding,
    this.fontSize = 18.0,
    this.raduis = 16,
    this.outline = false,
    this.border = true,
    this.buttonColor = kMainColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      child: ElevatedButton(
        onPressed: onPresed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(
              // horizontal: horzentalPadding == null ? 16.0 : horzentalPadding!,
              // vertical: verticalPadding == null ? 8.0 : verticalPadding!,
              ),
          backgroundColor:
              outline ? Theme.of(context).scaffoldBackgroundColor : buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(raduis ?? 4),
            side: BorderSide(width: 1.0, color: Colors.white),
          ),
        ),
        child: Center(
          child: label is String
              ? Text(
                  label,
                  style: TextStyle(
                    fontSize: fontSize,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                )
              : label,
        ),
      ),
    );
  }
}
