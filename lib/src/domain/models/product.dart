class Product {
  String? codProducto;
  String? codEmpresa;
  String? pluProducto;
  String nomProducto;
  String? codUnidadEmp;
  int? bonEntregaProducto;

  String? codGrupoProducto;
  String? estadoProducto;
  String? pluClaProducto;
  String? codMarcaMCodProveedor;
  String? codLinea;
  // int? impConsumo;
  // int? impEstampilla;
  String? referencia;
  String? talla;
  String? color;
  // int? peso;
  String? codBarra;
  String? estadoInactivo;
  // int? unidadVenta;
  String? imagen;
  String? unidadEmpPed;
  String? kit;
  // int? porcentajeDeIva;
  String? msControl;
  String? codUnilever;
  String? proplan002;
  String? proplan003;
  String? proplan004;
  String? proplan005;
  String? ccostos;
  String? un;
  String? cdn;
  String? tipoInv;
  int? createdById;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? codPrecio;

  double? precioProductoPrecio;
  // double? dctoProductoPrecio;
  //
  //
  // double? ico;
  // double? precioMin;
  // double? precioMax;
  // double? precioSugerido;
  // double? otroImp;
  double? existenciaStock;

  Product(
      {this.codProducto,
      this.codEmpresa,
      this.pluProducto,
      required this.nomProducto,
      this.codUnidadEmp,
      this.bonEntregaProducto,
      this.codGrupoProducto,
      this.estadoProducto,
      this.pluClaProducto,
      this.codMarcaMCodProveedor,
      this.codLinea,
      // this.impConsumo,
      // this.impEstampilla,
      this.referencia,
      this.talla,
      this.color,
      // this.peso,
      this.codBarra,
      this.estadoInactivo,
      // this.unidadVenta,
      this.imagen,
      this.unidadEmpPed,
      this.kit,
      // this.porcentajeDeIva,
      this.msControl,
      this.codUnilever,
      this.proplan002,
      this.proplan003,
      this.proplan004,
      this.proplan005,
      this.ccostos,
      this.un,
      this.cdn,
      this.tipoInv,
      this.createdById,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.codPrecio,
      this.precioProductoPrecio,
      // this.dctoProductoPrecio,
      // this.ico,
      // this.precioMin,
      // this.precioMax,
      // this.precioSugerido,
      // this.otroImp,
      this.existenciaStock});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        codProducto: json['CODPRODUCTO'],
        codEmpresa: json['CODEMPRESA'],
        pluProducto: json['PLUPRODUCTO'],
        nomProducto: json['NOMPRODUCTO'],
        codUnidadEmp: json['codunidademp'],
        bonEntregaProducto: json['BONENTREGAPRODUCTO'],
        codGrupoProducto: json['codgrupoproducto'],
        estadoProducto: json['estadoproducto'],
        pluClaProducto: json['pluclaproducto'],
        codMarcaMCodProveedor: json['codmarcamcodproveedor'],
        codLinea: json['codlinea'],
        // impConsumo: json['impconsumo'],
        // impEstampilla: json['impestampilla'],
        referencia: json['referencia'],
        talla: json['talla'],
        color: json['color'],
        // peso: json['peso'],
        codBarra: json['codbarra'],
        estadoInactivo: json['estadoinactivo'],
        // unidadVenta: json['unidadventa'],
        imagen: json['imagen'],
        unidadEmpPed: json['unidadempped'],
        kit: json['kit'],
        // porcentajeDeIva: json['procentajedeiva'],
        msControl: json['mscontrol'],
        codUnilever: json['codunilever'],
        proplan002: json['PROPLAN002'],
        proplan003: json['PROPLAN003'],
        proplan004: json['PROPLAN004'],
        proplan005: json['PROPLAN005'],
        ccostos: json['CCOSTOS'],
        un: json['UN'],
        cdn: json['cdn'],
        tipoInv: json['tipo_inv'],
        createdById: json['created_by_id'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        deletedAt: json['deleted_at'],
        codPrecio: json['codprecio'],
        precioProductoPrecio: json['precioproductoprecio'] is int
            ? json['precioproductoprecio'].toDouble()
            : json['precioproductoprecio'],
        // dctoProductoPrecio: json['DCTOPRODUCTOPRECIO'],
        // ico: json['ICO'],
        // precioMin: json['PRECIOMIN'],
        // precioMax: json['PRECIOMAX'],
        // precioSugerido: json['PRECIOSUGERIDO'],
        // otroImp: json['otroimp'],

        existenciaStock: json['EXISTENCIA_STOCK'] is int
            ? json['EXISTENCIA_STOCK'].toDouble()
            : json['EXISTENCIA_STOCK'],
      );

  Map<String, dynamic> toJson() => {
        'CODPRODUCTO': codProducto,
        'CODEMPRESA': codEmpresa,
        'PLUPRODUCTO': pluProducto,
        'NOMPRODUCTO': nomProducto,
        'codunidademp': codUnidadEmp,
        'BONENTREGAPRODUCTO': bonEntregaProducto,
        // 'codgrupoproducto': codGrupoProducto,
        // 'estadoproducto': estadoProducto,
        // 'pluclaproducto': pluClaProducto,
        // 'codmarcamcodproveedor': codMarcaMCodProveedor,
        // 'codlinea': codLinea,
        // 'impconsumo': impConsumo,
        // 'impestampilla': impEstampilla,
        // 'referencia': referencia,
        // 'talla': talla,
        // 'color': color,
        // 'peso': peso,
        // 'codbarra': codBarra,
        // 'estadoinactivo': estadoInactivo,
        // 'unidadventa': unidadVenta,
        // 'imagen': imagen,
        // 'unidadempped': unidadEmpPed,
        // 'kit': kit,
        // 'procentajedeiva': porcentajeDeIva,
        // 'mscontrol': msControl,
        // 'codunilever': codUnilever,
        // 'PROPLAN002': proplan002,
        // 'PROPLAN003': proplan003,
        // 'PROPLAN004': proplan004,
        // 'PROPLAN005': proplan005,
        // 'CCOSTOS': ccostos,
        // 'UN': un,
        // 'cdn': cdn,
        // 'tipo_inv': tipoInv,
        // 'created_by_id': createdById,
        // 'created_at': createdAt,
        // 'updated_at': updatedAt,
        // 'deleted_at': deletedAt,
        // 'codprecio': codPrecio,
        // 'precioproductoprecio': precioProductoPrecio,
        // 'DCTOPRODUCTOPRECIO': dctoProductoPrecio,
        // 'ICO': ico,
        // 'PRECIOMIN': precioMin,
        // 'PRECIOMAX': precioMax,
        // 'PRECIOSUGERIDO': precioSugerido,
        // 'otroimp': otroImp,
      };
}
