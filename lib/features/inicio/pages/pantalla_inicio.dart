import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../data/destinos_repository.dart';
import '../../acerca_de/pages/pantalla_acerca_de.dart';
import '../../categorias/pages/pantalla_categorias.dart';
import '../../catalogo/pages/pantalla_catalogo.dart';
import '../../favoritos/pages/pantalla_favoritos.dart';

class PantallaInicio extends StatelessWidget {
  const PantallaInicio({
    super.key,
    this.repository = const DestinosRepository(),
  });

  final DestinosRepository repository;

  void _abrirPantalla(BuildContext context, Widget pantalla) {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (_) => pantalla));
  }

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.travel_explore, color: colores.primary, size: 25),
            const SizedBox(width: 9),
            const Expanded(
              child: Text('Explora Oaxaca', overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Ver favoritos',
            onPressed: () => _abrirPantalla(context, const PantallaFavoritos()),
            icon: const Icon(Icons.favorite_border),
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 8, 18, 28),
          children: [
            _Portada(
              onTap: () => _abrirPantalla(
                context,
                PantallaCatalogo(repository: repository),
              ),
            ),
            const SizedBox(height: 28),
            Text(
              'Explora a tu manera',
              style: Theme.of(context).textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 5),
            Text(
              'Lugares únicos, historias y paisajes por descubrir.',
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(color: colores.onSurfaceVariant),
            ),
            const SizedBox(height: 16),
            _AccesoInicio(
              icono: Icons.place_outlined,
              titulo: 'Ver catálogo de destinos',
              detalle: 'Encuentra tu próximo lugar favorito',
              color: colores.primary,
              onTap: () => _abrirPantalla(
                context,
                PantallaCatalogo(repository: repository),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _AccesoCuadrado(
                    icono: Icons.category_outlined,
                    titulo: 'Categorías',
                    color: colores.tertiary,
                    onTap: () =>
                        _abrirPantalla(context, const PantallaCategorias()),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _AccesoCuadrado(
                    icono: Icons.favorite_border,
                    titulo: 'Favoritos',
                    color: AppTheme.bugambilia,
                    onTap: () => _abrirPantalla(
                      context,
                      PantallaFavoritos(repository: repository),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _AccesoInicio(
              icono: Icons.info_outline,
              titulo: 'Acerca del proyecto',
              detalle: 'Conoce más sobre Explora Oaxaca',
              color: AppTheme.turquesa,
              onTap: () => _abrirPantalla(context, const PantallaAcercaDe()),
            ),
          ],
        ),
      ),
    );
  }
}

class _Portada extends StatelessWidget {
  const _Portada({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(26),
    child: SizedBox(
      height: 300,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://traveltooaxaca.com/wp-content/uploads/2022/06/hierve-el-agua-FEAURED.jpg',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const ColoredBox(color: Color(0xFF315C45)),
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x16000000),
                  Color(0x33000000),
                  Color(0xD9000000),
                ],
                stops: [0, 0.42, 1],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 11,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.35),
                    ),
                  ),
                  child: const Text(
                    'NATURALEZA  ·  CULTURA  ·  AVENTURA',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                const SizedBox(height: 13),
                Text(
                  '¡Descubre Oaxaca!',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    height: 1.05,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Déjate sorprender por sus paisajes y lugares llenos de historia.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.92),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton.tonalIcon(
                  onPressed: onTap,
                  icon: const Icon(Icons.explore_outlined, size: 19),
                  label: const Text('Comenzar a explorar'),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppTheme.maiz,
                    foregroundColor: AppTheme.tinta,
                    minimumSize: const Size(0, 46),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _AccesoInicio extends StatelessWidget {
  const _AccesoInicio({
    required this.icono,
    required this.titulo,
    required this.detalle,
    required this.color,
    required this.onTap,
  });

  final IconData icono;
  final String titulo;
  final String detalle;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Card(
    color: color.withValues(alpha: 0.07),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: Row(
          children: [
            _IconoAcceso(icono: icono, color: color),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titulo,
                    style: Theme.of(context).textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    detalle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, size: 21),
          ],
        ),
      ),
    ),
  );
}

class _AccesoCuadrado extends StatelessWidget {
  const _AccesoCuadrado({
    required this.icono,
    required this.titulo,
    required this.color,
    required this.onTap,
  });

  final IconData icono;
  final String titulo;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Card(
    color: color.withValues(alpha: 0.12),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _IconoAcceso(icono: icono, color: color, tamano: 46),
            const SizedBox(height: 12),
            Text(
              titulo,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelLarge
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 2),
            Icon(
              Icons.arrow_forward,
              size: 16,
              color: Theme.of(context).colorScheme.outline,
            ),
          ],
        ),
      ),
    ),
  );
}

class _IconoAcceso extends StatelessWidget {
  const _IconoAcceso({
    required this.icono,
    required this.color,
    this.tamano = 46,
  });

  final IconData icono;
  final Color color;
  final double tamano;

  @override
  Widget build(BuildContext context) => Container(
    width: tamano,
    height: tamano,
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.22),
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: color.withValues(alpha: 0.18)),
    ),
    child: Icon(icono, color: color, size: 23),
  );
}
