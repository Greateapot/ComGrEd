import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IntFormField extends StatelessWidget {
  const IntFormField({
    super.key,
    required this.title,
    required this.onChanged,
    this.initialValue,
    this.titleStyle,
    this.controller,
    this.min = 0,
    this.max = 1,
    this.padding = const EdgeInsets.all(4.0),
  });

  final String title;
  final int? initialValue;
  final int min;
  final int max;
  final EdgeInsets padding;
  final TextStyle? titleStyle;
  final TextEditingController? controller;
  final void Function(int value) onChanged;

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Value can\'t be empty!';
    }

    final result = int.tryParse(value);

    if (result == null) {
      return 'Invalid value!';
    } else if (result < min) {
      return 'Value must be greater or equal to min!';
    } else if (result > max) {
      return 'Value must be less or equal to max!';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              title,
              style: titleStyle,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: controller,
              initialValue: initialValue?.toString(),
              keyboardType: const TextInputType.numberWithOptions(signed: true),
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.center,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: validator,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^-?\d+')),
              ],
              decoration: const InputDecoration(border: OutlineInputBorder()),
              onChanged: (value) {
                final result = int.tryParse(value);
                if (result == null) return;

                onChanged(result);
              },
            ),
          ),
        ],
      ),
    );
  }
}
