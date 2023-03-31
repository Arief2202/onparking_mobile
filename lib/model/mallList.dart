// ignore_for_file: camel_case_types, unnecessary_null_comparison, file_names, non_constant_identifier_names

class MallListResult {
  MallListResult({
    required this.success,
    required this.totalResults,
    required this.MallLists,
  });

  bool success;
  int totalResults;
  List<MallList> MallLists;

  factory MallListResult.fromJson(Map<String, dynamic> json) => MallListResult(
        success: json["success"],
        totalResults: json["totalResult"],
        MallLists: List<MallList>.from((json["mall"] as List).map((x) => MallList.fromJson(x)).where((content) => content.id != null && content.fotoMall != null && content.namaMall != null && content.alamatMall != null && content.openTimeMall != null && content.kuotaMall != null)),
      );
}

class MallList {
  int id;
  String fotoMall;
  String namaMall;
  String alamatMall;
  String openTimeMall;
  int kuotaMall;
  int? orderCount;
  List<Spot>? spot;

  MallList({
    required this.id,
    required this.fotoMall,
    required this.namaMall,
    required this.alamatMall,
    required this.openTimeMall,
    required this.kuotaMall,
    required this.orderCount,
    required this.spot,
  });

  factory MallList.fromJson(Map<String, dynamic> json) => MallList(
    id: json['id'], 
    fotoMall: json['fotoMall'], 
    namaMall: json['namaMall'], 
    alamatMall: json['alamatMall'], 
    openTimeMall: json['openTimeMall'], 
    kuotaMall: json['kuotaMall'], 
    orderCount: json['orderCount'], 
    spot: List<Spot>.from((json["spot_ready"] as List).map((x) => Spot.fromJson(x))),
  );
}

class Spot {
  String lantai;
  List<String> blok;
  Spot({
    required this.lantai,
    required this.blok,
  });
  factory Spot.fromJson(Map<String, dynamic> json) => Spot(
    lantai: json['lantai'],
    blok: List<String>.from((json["blok"] as List)),
  );
}

class OrderedSpotParkir{
  int id;
  int mall_id;
  int lantai;
  String blok;
  int carExist;
  String harga;
  OrderedSpotParkir({
    required this.id,
    required this.mall_id,
    required this.lantai,
    required this.blok,
    required this.carExist,
    required this.harga
  });
  
  factory OrderedSpotParkir.fromJson(Map<String, dynamic> json) => OrderedSpotParkir(
    id: json['id'], 
    mall_id: json['mall_id'], 
    lantai: json['lantai'], 
    blok: json['blok'], 
    carExist: json['carExist'], 
    harga: json['harga'],
  );
}