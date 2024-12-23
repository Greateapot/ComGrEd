import 'package:comgred/src/features/tree/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class TreeParametersForm extends StatelessWidget {
  const TreeParametersForm({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Text(
          'Parameters',
          style: textTheme.titleMedium
              ?.copyWith(color: colorScheme.onPrimaryContainer),
          textAlign: TextAlign.center,
        ),
        Expanded(
          child: ListView(
            children: const [
              Divider(),

              /// General
              Padding(
                padding: EdgeInsets.all(8.0),
                child: RandomSeedFormField(),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: IterationsCountFormField(),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TrunkChunkHeightFormField(),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: LeafHeigthFormField(),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: LeafWidthFormField(),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: AngleFormField(),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: AxiomFormField(),
              ),

              Divider(),

              /// Rules
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Rule0RulesFormField(),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Rule1RulesFormField(),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: RuleLCBRulesFormField(),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: RuleRCBRulesFormField(),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: RuleLSBRulesFormField(),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: RuleRSBRulesFormField(),
              ),

              Divider(),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: TreeRebuildButton(),
        ),
      ],
    );
  }
}
