class Destino {
  const Destino({
    required this.id,
    required this.nombre,
    required this.municipio,
    required this.ubicacion,
    required this.categoria,
    required this.descripcion,
    required this.historia,
    required this.actividades,
    required this.recomendaciones,
    required this.imagen,
  });

  final String id;
  final String nombre;
  final String municipio;
  final String ubicacion;
  final String categoria;
  final String descripcion;
  final String historia;
  final List<String> actividades;
  final List<String> recomendaciones;
  final String imagen;

  factory Destino.fromJson(Map<String, dynamic> json) {
    String requiredString(String key) {
      final value = json[key];
      if (value is String) return value;
      throw FormatException('El campo "$key" debe ser una cadena.');
    }

    List<String> stringList(String key) {
      final value = json[key];
      if (value is List && value.every((item) => item is String)) {
        return List<String>.unmodifiable(value.cast<String>());
      }
      throw FormatException('El campo "$key" debe ser una lista de cadenas.');
    }

    return Destino(
      id: requiredString('id'),
      nombre: requiredString('nombre'),
      municipio: requiredString('municipio'),
      ubicacion: requiredString('ubicacion'),
      categoria: requiredString('categoria'),
      descripcion: requiredString('descripcion'),
      historia: requiredString('historia'),
      actividades: stringList('actividades'),
      recomendaciones: stringList('recomendaciones'),
      imagen: requiredString('imagen'),
    );
  }
}
