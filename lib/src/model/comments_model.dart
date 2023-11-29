class CommentModel {
  String? oid;
  Post? postId;
  String? content;
  User? user;
  int? react;
  int? status;
  String? createdDate;
  String? updatedDate;

  CommentModel(
      {this.postId,
      this.oid,
      this.content,
      this.user,
      this.react,
      this.status,
      this.createdDate,
      this.updatedDate});

  CommentModel.fromJson(Map<String, dynamic> json) {
    oid = json['_id'];
    postId = json['post'] != null ? Post.fromJson(json['post']) : null;
    content = json['content'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    react = json['react'];
    status = json['status'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = oid;
    if (postId != null) {
      data['post'] = postId!.toJson();
    }
    data['content'] = content;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['react'] = react;
    data['status'] = status;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    return data;
  }
}

class Post {
  String? oid;

  Post({this.oid});

  Post.fromJson(dynamic json) {
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
