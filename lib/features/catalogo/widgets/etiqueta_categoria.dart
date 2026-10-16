import 'package:flutter/material.dart';

class EtiquetaCategoria extends StatelessWidget {
  const EtiquetaCategoria({super.key, required this.categoria});

  final String categoria;

  @override
  Widget build(BuildContext context) => Chip(
        avatar: Icon(
          Icons.local_offer_outlined,
          size: 15,
          color: Theme.of(context).colorScheme.secondary,
        ),
        label: Text(
          categoria,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSecondaryContainer,
            fontWeight: FontWeight.w600,
          ),
        ),
        visualDensity: VisualDensity.compact,
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(horizontal: 5),
      );
}
