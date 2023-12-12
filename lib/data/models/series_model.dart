class SeriesModel {
  int? code;
  String? status;
  String? copyright;
  String? attributionText;
  String? attributionHTML;
  String? etag;
  Data? data;

  SeriesModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    copyright = json['copyright'];
    attributionText = json['attributionText'];
    attributionHTML = json['attributionHTML'];
    etag = json['etag'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? offset;
  int? limit;
  int? total;
  int? count;
  List<Results>? results;

  Data({this.offset, this.limit, this.total, this.count, this.results});

  Data.fromJson(Map<String, dynamic> json) {
    offset = json['offset'];
    limit = json['limit'];
    total = json['total'];
    count = json['count'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }
}

class Results {
  int? id;
  String? title;
  String? description;
  String? resourceURI;

  int? startYear;
  int? endYear;
  String? rating;
  String? type;
  String? modified;
  Thumbnail? thumbnail;

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    resourceURI = json['resourceURI'];

    startYear = json['startYear'];
    endYear = json['endYear'];
    rating = json['rating'];
    type = json['type'];
    modified = json['modified'];
    thumbnail = json['thumbnail'] != null
        ? Thumbnail.fromJson(json['thumbnail'])
        : null;
  }
}

class Thumbnail {
  String? path;
  String? extension;

  Thumbnail.fromJson(Map<String, dynamic> json) {
    extension = json['extension'];
    path = '${json['path']}/standard_xlarge.jpg';
  }
}
