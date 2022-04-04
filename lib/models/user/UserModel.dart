class UserModel {
  int? id;
  String? name;
  String? mobile;
  String? email;
  String? image;
  String? educationalLevel;
  String? specialization;
  String? cv;
  String? type;
  String? accessToken;
  String? teacherRate;
  int? isNotify;

  UserModel(
      {this.id,
        this.name,
        this.mobile,
        this.email,
        this.image,
        this.educationalLevel,
        this.specialization,
        this.cv,
        this.type,
        this.teacherRate,
        this.isNotify,
        this.accessToken});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    image = json['image'];
    isNotify = json['is_notfy'];
    educationalLevel = json['educational_level'];
    specialization = json['specialization'];
    cv = json['cv'];
    type = json['type'].toString();
    accessToken = json['access_token'];
    teacherRate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['image'] = this.image;
    data['is_notfy'] = this.isNotify;
    data['educational_level'] = this.educationalLevel;
    data['specialization'] = this.specialization;
    data['cv'] = this.cv;
    data['type'] = this.type;
    data['access_token'] = this.accessToken;
    data['rate'] = this.teacherRate;
    return data;
  }
}
