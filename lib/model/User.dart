class User {
  String name;
  String headshot;

  User({this.name, this.headshot});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    headshot = json['headshot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['headshot'] = this.headshot;
    return data;
  }
}
