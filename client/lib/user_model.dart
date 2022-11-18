class Userlist {
  final String name;
  int? id;

  Userlist(
      {
      this.id,
      required this.name});

static Userlist fromJson(Map<String, dynamic> json) => Userlist (
  name : json['name'],
);

  // Userlist.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   name = json['name'];
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;

    return data;
  }
}