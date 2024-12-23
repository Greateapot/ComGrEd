import 'package:comgred/src/features/tree/data/models/tree_parameters.dart';
import 'package:comgred/src/features/tree/presentation/bloc/tree_bloc/tree_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LeafWidthFormField extends StatelessWidget {
  const LeafWidthFormField({super.key});

  String? validator(String? value) {
    if (value == null) {
      return 'Leaf width required!';
    }
    final leafWidth = int.parse(value);
    if (leafWidth <= 0) {
      return 'Leaf width must be greater than 0';
    } else if (leafWidth > 20) {
      return 'Leaf width must be less or equal than 20';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final parameters = context.select<TreeBloc, TreeParameters>(
      (bloc) => bloc.state.parameters,
    );
    return TextFormField(
      initialValue: parameters.leafWidth.toString(),
      onChanged: (value) {
        final leafWidth = int.tryParse(value);
        if (leafWidth == null) return;

        context.read<TreeBloc>().add(TreeUpdateParametersEvent(
              parameters: parameters.copyWith(leafWidth: leafWidth),
            ));
      },
      validator: validator,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: const InputDecoration(
        labelText: 'Leaf width',
        border: OutlineInputBorder(),
      ),
    );
  }
}
