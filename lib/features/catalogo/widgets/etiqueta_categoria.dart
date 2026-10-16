import 'package:flutter/material.dart';

class EtiquetaCategoria extends StatelessWidget {
  const EtiquetaCategoria({super.key, required this.categoria});

  final String categoria;

  @override
  Widget build(BuildContext context) => Chip(
    label: Text(categoria),
    visualDensity: VisualDensity.compact,
    backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
    side: BorderSide.none,
  );
}
