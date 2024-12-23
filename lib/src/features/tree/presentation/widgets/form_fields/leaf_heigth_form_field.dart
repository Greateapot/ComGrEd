import 'package:comgred/src/features/tree/data/models/tree_parameters.dart';
import 'package:comgred/src/features/tree/presentation/bloc/tree_bloc/tree_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LeafHeigthFormField extends StatelessWidget {
  const LeafHeigthFormField({super.key});

  String? validator(String? value) {
    if (value == null) {
      return 'Leaf height required!';
    }
    final leafHeight = int.parse(value);
    if (leafHeight <= 0) {
      return 'Leaf height must be greater than 0';
    } else if (leafHeight > 20) {
      return 'Leaf height must be less or equal than 20';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final parameters = context.select<TreeBloc, TreeParameters>(
      (bloc) => bloc.state.parameters,
    );

    return TextFormField(
      initialValue: parameters.leafHeight.toString(),
      onChanged: (value) {
        final leafHeight = int.tryParse(value);
        if (leafHeight == null) return;

        context.read<TreeBloc>().add(TreeUpdateParametersEvent(
              parameters: parameters.copyWith(leafHeight: leafHeight),
            ));
      },
      validator: validator,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: const InputDecoration(
        labelText: 'Leaf height',
        border: OutlineInputBorder(),
      ),
    );
  }
}
