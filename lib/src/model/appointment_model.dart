
class AppointmentModel {
  final String id;
  final User? user;
  final String? appointmentDate;
  final Pet? pet;
  final Service? service;
  final Doctor? doctor;
  final int? status;
  final String? createdDate;
  final String? updatedDate;

  AppointmentModel({
    required this.id,
    this.user,
    this.appointmentDate,
    this.pet,
    this.service,
    this.doctor,
    this.status,
    this.createdDate,
    this.updatedDate,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['_id'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      appointmentDate: json['appointmentDate'] ?? '',
      service: json['service'] != null ? Service.fromJson(json['service']) : null,
      doctor: json['doctor'] != null ? Doctor.fromJson(json['doctor']) : null,
      pet: json['pet'] != null ? Pet.fromJson(json['pet']) : null,
      status: json['status'] ?? '',
      createdDate: json['createdDate'] ?? '',
      updatedDate: json['updatedDate'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['appointmentDate'] = appointmentDate;
    if (pet != null) {
      data['pet'] = pet!.toJson();
    }
    if (service != null) {
      data['service'] = service!.toJson();
    }
    if (doctor != null) {
      data['doctor'] = doctor!.toJson();
    }
    data['status'] = status;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    return data;
  }
  
}

class User {
  String id;
  String? fullName;
  String? email;
  String? phone;
  String? address;

  User({required this.id, this.fullName, this.email, this.phone, this.address});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fullName'] = fullName;
    data['email'] = email;
    data['phone'] = phone;
    data['address'] = address;
    return data;
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

class Pet {
  String? id;
  String? name;
  String? birthDate;


  Pet({this.name, this.id, this.birthDate});

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      id: json['id'],
      name: json['name'],
      birthDate: json['birthDate'],

    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['birthDate'] = birthDate;

    return data;
  }
}

class Doctor {
  String? id;
  String? fullName;
  String? email;
  String? phone;
  String? address;

  Doctor({this.fullName, this.email, this.phone, this.address});

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      fullName: json['fullName'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fullName'] = fullName;
    data['email'] = email;
    data['phone'] = phone;
    data['address'] = address;
    return data;
  }
}