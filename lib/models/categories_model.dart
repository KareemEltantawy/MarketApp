//class CategoriesModel {
//  bool status;
//  Null message;
//  Data data;
//
//  CategoriesModel({this.status, this.message, this.data});
//
//  CategoriesModel.fromJson(Map<String, dynamic> json) {
//    status = json['status'];
//    message = json['message'];
//    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['status'] = this.status;
//    data['message'] = this.message;
//    if (this.data != null) {
//      data['data'] = this.data.toJson();
//    }
//    return data;
//  }
//}
//
//class Data {
//  int currentPage;
//  List<Data> data;
//  String firstPageUrl;
//  int from;
//  int lastPage;
//  String lastPageUrl;
//  Null nextPageUrl;
//  String path;
//  int perPage;
//  Null prevPageUrl;
//  int to;
//  int total;
//
//  Data(
//      {this.currentPage,
//        this.data,
//        this.firstPageUrl,
//        this.from,
//        this.lastPage,
//        this.lastPageUrl,
//        this.nextPageUrl,
//        this.path,
//        this.perPage,
//        this.prevPageUrl,
//        this.to,
//        this.total});
//
//  Data.fromJson(Map<String, dynamic> json) {
//    currentPage = json['current_page'];
//    if (json['data'] != null) {
//      data = new List<Data>();
//      json['data'].forEach((v) {
//        data.add(new Data.fromJson(v));
//      });
//    }
//    firstPageUrl = json['first_page_url'];
//    from = json['from'];
//    lastPage = json['last_page'];
//    lastPageUrl = json['last_page_url'];
//    nextPageUrl = json['next_page_url'];
//    path = json['path'];
//    perPage = json['per_page'];
//    prevPageUrl = json['prev_page_url'];
//    to = json['to'];
//    total = json['total'];
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['current_page'] = this.currentPage;
//    if (this.data != null) {
//      data['data'] = this.data.map((v) => v.toJson()).toList();
//    }
//    data['first_page_url'] = this.firstPageUrl;
//    data['from'] = this.from;
//    data['last_page'] = this.lastPage;
//    data['last_page_url'] = this.lastPageUrl;
//    data['next_page_url'] = this.nextPageUrl;
//    data['path'] = this.path;
//    data['per_page'] = this.perPage;
//    data['prev_page_url'] = this.prevPageUrl;
//    data['to'] = this.to;
//    data['total'] = this.total;
//    return data;
//  }
//}
//
//class Data {
//  int id;
//  String name;
//  String image;
//
//  Data({this.id, this.name, this.image});
//
//  Data.fromJson(Map<String, dynamic> json) {
//    id = json['id'];
//    name = json['name'];
//    image = json['image'];
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['id'] = this.id;
//    data['name'] = this.name;
//    data['image'] = this.image;
//    return data;
//  }
//}


class CategoriesModel {
  bool? status;
  Null message;
  Data? data;


  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }


}

class Data {
  int? currentPage;
  List<CData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  Null nextPageUrl;
  String? path;
  int? perPage;
  Null prevPageUrl;
  int? to;
  int? total;



  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(new CData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }


}

class CData {
  int? id;
  String? name;
  String? image;


  CData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }


}

