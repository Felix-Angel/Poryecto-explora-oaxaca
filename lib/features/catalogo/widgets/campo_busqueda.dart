import 'package:flutter/material.dart';

class CampoBusqueda extends StatefulWidget {
  const CampoBusqueda({
    super.key,
    required this.texto,
    required this.onChanged,
  });

  final String texto;
  final ValueChanged<String> onChanged;

  @override
  State<CampoBusqueda> createState() => _CampoBusquedaState();
}

class _CampoBusquedaState extends State<CampoBusqueda> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.texto);
  }

  @override
  void didUpdateWidget(covariant CampoBusqueda oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.texto != widget.texto && _controller.text != widget.texto) {
      _controller.value = TextEditingValue(
        text: widget.texto,
        selection: TextSelection.collapsed(offset: widget.texto.length),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => TextField(
    controller: _controller,
    onChanged: widget.onChanged,
    decoration: InputDecoration(
      hintText: 'Buscar destino',
      prefixIcon: const Icon(Icons.search),
      filled: true,
      fillColor: Theme.of(context).colorScheme.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    ),
  );
}
