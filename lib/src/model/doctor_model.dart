class DoctorModel {
  String? id;
  Avatar? avatar;
  String? fullName;
  String? email;
  int? gender;
  int? status;
  String? phone;
  String? major;
  String? birthDate;
  String? introduce;
  Experience? experience;
  Account? account;
  Address? address;
  String? createdDate;
  String? updatedDate;

  DoctorModel({
    this.id,
    this.avatar,
    this.fullName,
    this.email,
    this.account,
    this.address,
    this.birthDate,
    this.experience,
    this.gender,
    this.introduce,
    this.major,
    this.phone,
    this.status,
    this.createdDate,
    this.updatedDate,
  });

  DoctorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avatar =
        json['avatar'] != null ? Avatar.fromJson(json['avatar']) : null;
    fullName = json['fullName'];
    email = json['email'];
    gender = json['gender'];
    status = json['status'];
    phone = json['phone'];
    major = json['major'];
    birthDate = json['birthDate'];
    introduce = json['introduce'];
    experience = json['experience'] != null
        ? Experience.fromJson(json['experience'])
        : null;
    account = json['account'] != null ? Account.fromJson(json['account']) : null;
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (avatar != null) {
      data['avatar'] = avatar!.toJson();
    }
    data['fullName'] = fullName;
    data['email'] = email;
    data['gender'] = gender;
    data['status'] = status;
    data['phone'] = phone;
    data['major'] = major;
    data['birthDate'] = birthDate;
    data['introduce'] = introduce;
    if (experience != null) {
      data['experience'] = experience!.toJson();
    }
    if (account != null) {
      data['account'] = account!.toJson();
    }
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    return data;
  }
  
}

class Account {
  String? username;
  String? password;
  String? role;

  Account({this.username, this.password, this.role});

  Account.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    data['role'] = role;
    return data;
  }
}

class Experience {
  String? startDate;
  String? endDate;
  String? job;

  Experience({this.startDate, this.endDate, this.job});

  Experience.fromJson(Map<String, dynamic> json) {
    startDate = json['startDate'];
    endDate = json['endDate'];
    job = json['job'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['job'] = job;
    return data;
  }
}

class Address {
  String? detail;

  Address({this.detail});

  Address.fromJson(Map<String, dynamic> json) {
    detail = json['detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['detail'] = detail;
    return data;
  }
}

class Avatar {
  String? link;

  Avatar({this.link});

  Avatar.fromJson(Map<String, dynamic> json) {
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['link'] = link;
    return data;
  }
}