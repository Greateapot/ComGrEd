import 'package:comgred/src/features/tree/data/models/tree_parameters.dart';
import 'package:comgred/src/features/tree/presentation/bloc/tree_bloc/tree_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IterationsCountFormField extends StatelessWidget {
  const IterationsCountFormField({super.key});

  String? validator(String? value) {
    if (value == null) {
      return 'Iterations count required!';
    }
    final iterationsCount = int.parse(value);
    if (iterationsCount <= 0) {
      return 'Iterations count must be greater than 0';
    } else if (iterationsCount > 5) {
      return 'Iterations count must be less or equal than 5';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final parameters = context.select<TreeBloc, TreeParameters>(
      (bloc) => bloc.state.parameters,
    );
    return TextFormField(
      initialValue: parameters.iterationsCount.toString(),
      onChanged: (value) {
        final iterationsCount = int.tryParse(value);
        if (iterationsCount == null) return;

        context.read<TreeBloc>().add(TreeUpdateParametersEvent(
              parameters: parameters.copyWith(iterationsCount: iterationsCount),
            ));
      },
      validator: validator,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: const InputDecoration(
        labelText: 'Iterations Count',
        border: OutlineInputBorder(),
      ),
    );
  }
}
