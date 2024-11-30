import 'package:flutter/material.dart';

class BasicTextField extends StatelessWidget {
  const BasicTextField({
    Key? key,
    this.hintText,
    this.labelText,
    this.controller,
    this.suffix,
    this.prefix,
    this.readOnly = false,
    this.validator,
    this.keyboardType,
    this.onTap, this.onChanged,
  }) : super(key: key);

  final String? hintText, labelText;
  final TextEditingController? controller;
  final Widget? suffix, prefix;
  final bool readOnly;
  final String? Function(String? value)? validator;
  final TextInputType? keyboardType;
  final VoidCallback? onTap;
  final Function(String value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          Text(
            labelText!,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 2.0,
          child: Container(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                if (prefix != null) prefix!,
                if (prefix != null) SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    readOnly: readOnly,
                    validator: validator,
                    onChanged: onChanged,
                    keyboardType: keyboardType,
                    onTap: onTap,
                    decoration: InputDecoration.collapsed(
                      hintText: hintText,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if (suffix != null) SizedBox(width: 8),
                if (suffix != null) suffix!,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
