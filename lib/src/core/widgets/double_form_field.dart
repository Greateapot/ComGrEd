import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DoubleFormField extends StatelessWidget {
  const DoubleFormField({
    super.key,
    required this.title,
    required this.onChanged,
    this.initialValue,
    this.titleStyle,
    this.controller,
    this.min = 0,
    this.max = 1,
    this.fractionDigits = 3,
    this.padding = const EdgeInsets.all(4.0),
  });

  final String title;
  final double? initialValue;
  final double min;
  final double max;
  final EdgeInsets padding;
  final int fractionDigits;
  final TextStyle? titleStyle;
  final TextEditingController? controller;
  final void Function(double value) onChanged;

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Value can\'t be empty!';
    }

    final result = double.tryParse(value);

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
              initialValue: initialValue?.toStringAsFixed(fractionDigits),
              keyboardType: const TextInputType.numberWithOptions(
                signed: true,
                decimal: true,
              ),
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.center,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: validator,
              inputFormatters: [
                FilteringTextInputFormatter.deny(',', replacementString: '.'),
                FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*')),
              ],
              decoration: const InputDecoration(border: OutlineInputBorder()),
              onChanged: (value) {
                final result = double.tryParse(value);
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
