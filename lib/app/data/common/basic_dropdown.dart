import 'package:flutter/material.dart';

class BasicDropdown<T> extends StatelessWidget {
  const BasicDropdown({
    Key? key,
    this.hintText,
    this.labelText,
    this.suffix,
    this.prefix,
    this.validator,
    required this.items,
    this.value,
    required this.onChanged,
    required this.builder,
  }) : super(key: key);

  final String? hintText, labelText;
  final Widget? suffix, prefix;

  final List<T> items;
  final T? value;
  final Function(T? value) onChanged;
  final Widget Function(T) builder;
  final String? Function(T? value)? validator;

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
            padding: const EdgeInsets.only(top: 8),
            child: DropdownButtonFormField<T>(
              validator: validator,
              value: value,
              items: items
                  .map(
                    (e) => DropdownMenuItem<T>(value: e, child: builder(e)),
                  )
                  .toList(),
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}