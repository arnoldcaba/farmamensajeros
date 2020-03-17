class Direccion {
  String ciudad;
  String detalles;
  String direccion;

  Direccion({ this.ciudad, this.detalles, this.direccion });

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is Direccion &&
    runtimeType == other.runtimeType &&
    ciudad == other.ciudad &&
    direccion == other.direccion &&
    detalles == other.detalles;

  @override
  int get hashCode => ciudad.hashCode ^ direccion.hashCode ^ detalles.hashCode ;
}