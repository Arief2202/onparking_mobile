// ignore_for_file: camel_case_types, unnecessary_null_comparison, file_names, non_constant_identifier_names

class bookingStatusResult {
  bookingStatusResult({
    required this.success,
    required this.totalResults,
    required this.mall,
    required this.status,
  });

  bool success;
  int totalResults;
  List<MallListModel> mall;
  List<Status> status;

  factory bookingStatusResult.fromJson(Map<String, dynamic> json) => bookingStatusResult(
        success: json["success"],
        totalResults: json["status"],
        mall: List<MallListModel>.from((json["mall"] as List).map((x) => MallListModel.fromJson(x)).where((content) => content.id != null)),
        status: List<Status>.from((json["mall"] as List).map((x) => Status.fromJson(x)).where((content) => content.id != null)),
      );
}

class MallListModel {
  int id;
  String fotoMall;
  String namaMall;
  String alamatMall;
  String openTimeMall;
  String kuotaMall;
  String orderCount;

  MallListModel({
    required this.id,
    required this.fotoMall,
    required this.namaMall,
    required this.alamatMall,
    required this.openTimeMall,
    required this.kuotaMall,
    required this.orderCount,
  });

  factory MallListModel.fromJson(Map<String, dynamic> json) => MallListModel(id: json['id'], fotoMall: json['fotoMall'], namaMall: json['namaMall'], alamatMall: json['alamatMall'], openTimeMall: json['openTimeMall'], kuotaMall: json['kuotaMall'], orderCount: json['orderCount']);
}

class Status {
  int id;
  String mall_id;
  String user_id;
  String progress;
  String created_at;

  Status({
    required this.id,
    required this.mall_id,
    required this.user_id,
    required this.progress,
    required this.created_at,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(id: json['id'], mall_id: json['mall_id'], user_id: json['user_id'], progress: json['progress'], created_at: json['created_at']);
}
