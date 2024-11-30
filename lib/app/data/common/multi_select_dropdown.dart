// Multi Select widget
// This widget is reusable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabee3_flutter/app/data/common/basic_button.dart';
import 'package:tabee3_flutter/app/data/common/constants.dart';

class CustomMultiselectDropDown<T> extends StatefulWidget {
  final List<T> items;
  final List<T> selectedItems;
  final Function(List<T> values) onChanged;
  final Widget Function(BuildContext context, int index) builder;
  final String title;
  const CustomMultiselectDropDown({
    Key? key,
    required this.items,
    required this.selectedItems,
    required this.onChanged,
    required this.builder,
    required this.title,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomMultiselectDropDownState();
}

class _CustomMultiselectDropDownState<T>
    extends State<CustomMultiselectDropDown> {
  // this variable holds the selected items
  List _selectedItems = <T>[];

  @override
  void initState() {
    super.initState();
    _selectedItems = widget.selectedItems as List<T>;
  }

// This function is triggered when a checkbox is checked or unchecked
  void _itemChange(T itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue);
      } else {
        _selectedItems.remove(itemValue);
      }
    });
  }

  // this function is called when the Cancel button is pressed
  void _cancel() {
    Navigator.pop(context);
  }

// this function is called when the Submit button is tapped
  void _submit() {
    Navigator.pop(context, _selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: _selectedItems.length == widget.items.length,
                  fillColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.selected)) {
                      return kMainColor;
                    }
                    return Colors.grey;
                  }),
                   onChanged: (bool? value) {
                   if(!value!)
                     {
                      _selectedItems.removeRange(0, _selectedItems.length);
                      setState(() {});
                      print( widget.selectedItems.length);
                     }
                   else{
                     widget.selectedItems.removeRange(0, widget.selectedItems.length);
                     for(var item in widget.items)
                       {
                         _selectedItems.add(item);
                       }
                     setState(() {
                     });
                     print( widget.selectedItems.length);
                   }
                  },
                ),
                Text("Choose All".tr)
              ],
            ),
            ListBody(
              children: widget.items.asMap().entries.map((MapEntry<int, dynamic> item) => CheckboxListTile(
                        value: _selectedItems.contains(item.value),
                        title: widget.builder(context, item.key),
                        controlAffinity: ListTileControlAffinity.leading,

                        onChanged: (isChecked) => _itemChange((item.value as T), isChecked!),
                      )).toList(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _cancel,
          child: Text('Cancel'.tr),
        ),
        BasicButton(
          onPresed: _submit,
          label: 'Submit'.tr,
        ),
      ],
    );
  }
}
