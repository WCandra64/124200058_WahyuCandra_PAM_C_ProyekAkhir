class DataModel {
  List<Data>? data;

  DataModel({
    this.data,
  });

  DataModel.fromJson(List<dynamic> json){
    if (json != null) {
      data = <Data>[];
      json.forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  Map<String, dynamic>? bio;
  String? imgCover;
  String? imgDtl;
  String? gender;
  String? weight;
  String? height;
  Map<String, dynamic>? work;

  Data({
    this.id,
    this.name,
    this.bio,
    this.imgCover,
    this.imgDtl,
    this.gender,
    this.weight,
    this.height,
    this.work,
  });

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    bio = json['biography'];
    imgCover = json['images']['md'];
    imgDtl = json['images']['lg'];
    gender = json['appearance']['gender'];
    weight = json['appearance']['weight'][1];
    height = json['appearance']['height'][1];
    work = json['work'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['bio'] = this.bio;
    data['imgCov'] = this.imgCover;
    data['imgDtl'] = this.imgDtl;
    data['gender'] = this.gender;
    data['weight'] = this.weight;
    data['height'] = this.height;
    data['work'] = this.work;
    return data;
  }
}