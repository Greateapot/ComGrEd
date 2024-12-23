import 'package:comgred/src/features/tree/data/models/tree_parameters.dart';
import 'package:comgred/src/features/tree/presentation/bloc/tree_bloc/tree_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrunkChunkHeightFormField extends StatelessWidget {
  const TrunkChunkHeightFormField({super.key});

  String? validator(String? value) {
    if (value == null) {
      return 'Trunk chunk height required!';
    }
    final trunkChunkHeight = int.parse(value);
    if (trunkChunkHeight <= 0) {
      return 'Trunk chunk height must be greater than 0';
    } else if (trunkChunkHeight > 30) {
      return 'Trunk chunk height must be less or equal than 30';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final parameters = context.select<TreeBloc, TreeParameters>(
      (bloc) => bloc.state.parameters,
    );

    return TextFormField(
      initialValue: parameters.trunkChunkHeight.toString(),
      onChanged: (value) {
        final trunkChunkHeight = int.tryParse(value);
        if (trunkChunkHeight == null) return;

        context.read<TreeBloc>().add(TreeUpdateParametersEvent(
              parameters:
                  parameters.copyWith(trunkChunkHeight: trunkChunkHeight),
            ));
      },
      validator: validator,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: const InputDecoration(
        labelText: 'Trunk chunk height',
        border: OutlineInputBorder(),
      ),
    );
  }
}
