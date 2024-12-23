import 'package:comgred/src/features/tree/data/models/tree_parameters.dart';
import 'package:comgred/src/features/tree/presentation/bloc/tree_bloc/tree_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AngleFormField extends StatelessWidget {
  const AngleFormField({super.key});

  String? validator(String? value) {
    if (value == null) {
      return 'Angle required!';
    }
    final angle = int.parse(value);
    if (angle <= 0) {
      return 'Angle must be greater than 0';
    } else if (angle > 180) {
      return 'Angle must be less or equal than 180';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final parameters = context.select<TreeBloc, TreeParameters>(
      (bloc) => bloc.state.parameters,
    );

    return TextFormField(
      initialValue: parameters.angle.toString(),
      onChanged: (value) {
        final angle = int.tryParse(value);
        if (angle == null) return;

        context.read<TreeBloc>().add(TreeUpdateParametersEvent(
              parameters: parameters.copyWith(angle: angle),
            ));
      },
      validator: validator,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: const InputDecoration(
        labelText: 'Angle',
        border: OutlineInputBorder(),
      ),
    );
  }
}
