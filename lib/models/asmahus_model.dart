class DataAsma {
  List<Data>? data;
  int? statusCode;
  int? total;

  DataAsma({this.data, this.statusCode, this.total});

  DataAsma.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    statusCode = json['statusCode'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['statusCode'] = this.statusCode;
    data['total'] = this.total;
    return data;
  }
}

class Data {
  int? urutan;
  String? latin;
  String? arab;
  String? arti;

  Data({this.urutan, this.latin, this.arab, this.arti});

  Data.fromJson(Map<String, dynamic> json) {
    urutan = json['urutan'];
    latin = json['latin'];
    arab = json['arab'];
    arti = json['arti'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['urutan'] = this.urutan;
    data['latin'] = this.latin;
    data['arab'] = this.arab;
    data['arti'] = this.arti;
    return data;
  }
}
