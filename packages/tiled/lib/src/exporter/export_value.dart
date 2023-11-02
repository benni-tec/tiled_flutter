part of tiled;

abstract class ExportValue implements ExportObject, ExportResolver {
  const ExportValue();

  String get xml;
  dynamic get json;

  @override
  XmlNode exportXml() => XmlText(xml);

  @override
  dynamic exportJson() => json;
}

class ExportLiteral<T> extends ExportValue {
  final T value;

  const ExportLiteral(this.value);

  @override
  T get json => value;

  @override
  String get xml => value.toString();
}

extension ExportableString on String {
  ExportValue toExport() => ExportLiteral<String>(this);
}

extension ExportableNum on num {
  ExportValue toExport() => ExportLiteral<num>(this);
}

class _ExportableBool extends ExportValue {
  final bool value;

  _ExportableBool(this.value);

  @override
  bool get json => value;

  @override
  String get xml => (value ? 1 : 0).toString();
}

extension ExportableBool on bool {
  ExportValue toExport() => _ExportableBool(this);
}

class _ExportableColor extends ExportValue {
  final Color color;

  const _ExportableColor(this.color);

  static String _hex(int value) {
    return value.toRadixString(16).padLeft(2, '0');
  }

  String get export =>
      '#${_hex(color.alpha)}${_hex(color.red)}${_hex(color.green)}${_hex(color.blue)}';

  @override
  String get json => export;

  @override
  String get xml => export;
}

extension ExportableColor on Color {
  ExportValue toExport() => _ExportableColor(this);
}

class _ExportablePointList extends ExportValue {
  final List<Point> points;

  _ExportablePointList(this.points);

  @override
  Iterable<Map<String, double>> get json => points.map((e) => {
        'x': e.x,
        'y': e.y,
      });

  @override
  String get xml => points.map((e) => '${e.x},${e.y}').join(' ');
}

extension ExportablePointList on List<Point> {
  ExportValue toExport() => _ExportablePointList(this);
}
