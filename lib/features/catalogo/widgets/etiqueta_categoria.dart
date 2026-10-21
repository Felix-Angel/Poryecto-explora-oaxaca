import 'package:flutter/material.dart';

class EtiquetaCategoria extends StatelessWidget {
  const EtiquetaCategoria({super.key, required this.categoria});

  final String categoria;

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).colorScheme;
    return Chip(
      avatar: Icon(
        Icons.local_offer_outlined,
        size: 15,
        color: colores.secondary,
      ),
      label: Text(
        categoria,
        style: TextStyle(
        color: colores.onSecondaryContainer,
          fontWeight: FontWeight.w600,
        ),
      ),
      visualDensity: VisualDensity.compact,
      backgroundColor: colores.secondaryContainer,
      side: BorderSide.none,
      padding: const EdgeInsets.symmetric(horizontal: 5),
    );
  }
}
