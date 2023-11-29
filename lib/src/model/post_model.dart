class PostModel {
  String? id;
  Avatar? avatar;
  String? content;
  User? user;
  int? status;
  int? react;
  String? createdDate;
  String? updatedDate;
  List<Comments>? comments;

  PostModel(
      {this.id,
      this.avatar,
      this.content,
      this.user,
      this.status,
      this.react,
      this.createdDate,
      this.updatedDate,
      this.comments});

  PostModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    avatar = json['avatar'] != null ? Avatar.fromMap(json['avatar']) : null;
    content = json['content'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    status = json['status'];
    react = json['react'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    if (avatar != null) {
      data['avatar'] = avatar!.toMap();
    }
    data['content'] = content;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['status'] = status;
    data['react'] = react;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Avatar {
  Avatar({
    required this.url,
  });

  String url;

  factory Avatar.fromMap(Map<String, dynamic> map) {
    return Avatar(
      url: map['link'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'link': url,
    };
  }
}

class User {
  User({
    this.id,
    this.name,
    this.avatar,
  });

  String? id;
  String? name;
  Avatar? avatar;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['fullName'],
      avatar: json['avatar'] != null ? Avatar.fromMap(json['avatar']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fullName'] = name;
    if (avatar != null) {
      data['avatar'] = avatar!.toMap();
    }
    return data;
  }
}

class Comments {
  String? oid;

  Comments({this.oid});

  Comments.fromJson(dynamic json) {
    if (json is String) {
      oid = json;
    } else if (json is Map<String, dynamic> && json.containsKey('$oid')) {
      oid = json['$oid'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$oid'] = oid;
    return data;
  }
}
