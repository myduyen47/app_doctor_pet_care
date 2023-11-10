class ListPetOwnerModel {
    final Pet? pet;
    final User? user;

    ListPetOwnerModel({
        this.pet,
        this.user,
    });

factory ListPetOwnerModel.fromJson(Map<String, dynamic> json) {
  return ListPetOwnerModel(
    pet: json['pet'] != null ? Pet.fromJson(json['pet']) : null,
    user: json['user'] != null ? User.fromJson(json['user']) : null,
  );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        if (pet != null) {
            data['pet'] = pet!.toJson();
        }
        if (user != null) {
            data['user'] = user!.toJson();
        }
        return data;
    
   }
     
}

class Pet {
  String? id;
  Avatar? avatar;
  String? name;
  Type? type;
  String? birthDate;
  int? gender;
  UserPet? user;
  String? color;
  int? weight;
  String? describe;
  String? medicalHistory;
  String? createdDate;
  String? updatedDate;

  Pet({
    this.id,
    this.avatar,
    this.name,
    this.type,
    this.birthDate,
    this.color,
    this.createdDate,
    this.describe,
    this.gender,
    this.medicalHistory,
    this.updatedDate,
    this.user,
    this.weight,
  });

 factory Pet.fromJson(Map<String, dynamic> json) {
  return Pet(
    id: json['id'],
    avatar: json['avatar'] != null ? Avatar.fromJson(json['avatar']) : null,
    name: json['name'],
    type: json['type'] != null ? Type.fromJson(json['type']) : null,
    birthDate: json['birthDate'],
    color: json['color'],
    createdDate: json['createdDate'],
    describe: json['describe'],
    gender: json['gender'],
    medicalHistory: json['medicalHistory'],
    updatedDate: json['updatedDate'],
    user: json['user'] != null ? UserPet.fromJson(json['user']) : null,
    weight: json['weight'],
  );
  }

  Map<String, dynamic> toJson() {
    final  Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (avatar != null) {
      data['avatar'] = avatar!.toJson();
    }
    data['name'] = name;
    if (type != null) {
      data['type'] = type!.toJson();
    }
    data['birthDate'] = birthDate;
    data['color'] = color;
    data['createdDate'] = createdDate;
    data['describe'] = describe;
    data['medicalHistory'] = medicalHistory;
    data['updatedDate'] = updatedDate;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['weight'] = weight;
    return data;

  }
}

class UserPet {
  String id;
  String? fullName;


  UserPet({required this.id, this.fullName});

  factory UserPet.fromJson(Map<String, dynamic> json) {
    return UserPet(
      id: json['id'],
      fullName: json['fullName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fullName'] = fullName;

    return data;
  }
}

class Avatar {
  String? link;

  Avatar({this.link});

  factory Avatar.fromJson(Map<String, dynamic> json) {
    return Avatar(
      link: json['link'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['link'] = link;
    return data;
  }
}

class Type {
  String? id;
  String? name;

  Type({this.id, this.name});

  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class User {
  String? id;
  String? fullName;
  String? email;
  String? phone;
  String? address;
  String? createdDate;
  String? updatedDate;

  User({
    this.id,
    this.fullName,
    this.email,
    this.phone,
    this.address,
    this.createdDate,
    this.updatedDate,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      createdDate: json['createdDate'],
      updatedDate: json['updatedDate'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fullName'] = fullName;
    data['email'] = email;
    data['phone'] = phone;
    data['address'] = address;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    return data;
  }
}