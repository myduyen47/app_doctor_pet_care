class ListPetOwnerModel {
    final Pet? pet;
    final User? user;
    List<Health>? health;
    List<Appointment>? appointments;

    ListPetOwnerModel({
        this.pet,
        this.user,
        this.health,
        this.appointments,
    });

factory ListPetOwnerModel.fromJson(Map<String, dynamic> json) {
  return ListPetOwnerModel(
    pet: json['pet'] != null ? Pet.fromJson(json['pet']) : null,
    user: json['user'] != null ? User.fromJson(json['user']) : null,
    health: json['health'] != null ? (json['health'] as List).map((e) => Health.fromJson(e)).toList() : null,
    appointments: json['appointments'] != null ? (json['appointments'] as List).map((e) => Appointment.fromJson(e)).toList() : null,
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
        if (health != null) {
            data['health'] = health!.map((v) => v.toJson()).toList();
        }
        if (appointments != null) {
            data['appointments'] = appointments!.map((v) => v.toJson()).toList();
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
    id: json['_id'],
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
    data['_id'] = id;
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
  Address? address;
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
      id: json['_id'],
      fullName: json['fullName'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'] != null ? Address.fromJson(json['address']) : null,
      createdDate: json['createdDate'],
      updatedDate: json['updatedDate'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['fullName'] = fullName;
    data['email'] = email;
    data['phone'] = phone;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
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

class Health {
  String? id;
  Type? pet;
  UserPet? user;
  int? type;
  String? data;
  String? createdDate;
  String? updatedDate;

  Health({
    this.id,
    this.pet,
    this.user,
    this.type,
    this.data,
    this.createdDate,
    this.updatedDate,
  });

  factory Health.fromJson(Map<String, dynamic> json) {
    return Health(
      id: json['_id'],
      pet: json['pet'] != null ? Type.fromJson(json['pet']) : null,
      user: json['user'] != null ? UserPet.fromJson(json['user']) : null,
      type: json['type'],
      data: json['data'],
      createdDate: json['createdDate'],
      updatedDate: json['updatedDate'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataHealth = <String, dynamic>{};
    dataHealth['_id'] = id;
    if (pet != null) {
      dataHealth['pet'] = pet!.toJson();
    }
    if (user != null) {
      dataHealth['user'] = user!.toJson();
    }
    dataHealth['type'] = type;
    dataHealth['data'] = data;
    dataHealth['createdDate'] = createdDate;
    dataHealth['updatedDate'] = updatedDate;
    return dataHealth;
  }
}

class Service {
  String? name;
  String? price;

  Service({this.name, this.price});

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      name: json['name'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['price'] = price;
    return data;
  }
}

class Appointment {
  Service? service;
  int? status;
  String? appointmentDate;

  Appointment({this.service, this.status, this.appointmentDate});

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      service: json['service'] != null ? Service.fromJson(json['service']) : null,
      status: json['status'],
      appointmentDate: json['appointmentDate'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (service != null) {
      data['service'] = service!.toJson();
    }
    data['status'] = status;
    data['appointmentDate'] = appointmentDate;
    return data;
  }
}