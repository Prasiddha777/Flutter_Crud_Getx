class TodoModel {
  String? title;
  String? dec;
  String? id;

  TodoModel({this.title, this.dec, this.id});

  TodoModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    dec = json['dec'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['dec'] = this.dec;
    data['id'] = this.id;
    return data;
  }
}
