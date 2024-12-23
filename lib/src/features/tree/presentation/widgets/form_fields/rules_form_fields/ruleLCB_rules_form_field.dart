import 'package:comgred/src/features/tree/data/models/tree_parameters.dart';
import 'package:comgred/src/features/tree/data/utils/tree_rules_validator.dart';
import 'package:comgred/src/features/tree/presentation/bloc/tree_bloc/tree_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RuleLCBRulesFormField extends StatelessWidget {
  const RuleLCBRulesFormField({super.key});

  String? validator(String? value) {
    if (value == null) {
      return 'Rule LCB required!';
    } else if (!TreeRulesValidator.validate(value)) {
      return 'Invalid input!';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final parameters = context.select<TreeBloc, TreeParameters>(
      (bloc) => bloc.state.parameters,
    );
    return TextFormField(
      initialValue: parameters.rules.ruleLCB,
      onChanged: (value) {
        if (value.isEmpty) return;

        context.read<TreeBloc>().add(TreeUpdateParametersEvent(
              parameters: parameters.copyWith(
                  rules: parameters.rules.copyWith(ruleLCB: value)),
            ));
      },
      validator: validator,
      decoration: const InputDecoration(
        labelText: 'Rule LCB',
        border: OutlineInputBorder(),
      ),
    );
  }
}
