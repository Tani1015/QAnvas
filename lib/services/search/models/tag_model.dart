class TagModel {
  String? id;
  String? title;

  TagModel({
    this.id,
    this.title
  });

  TagModel.fromMap(Map<String,dynamic> data){
    id = data['id'];
    title = data['title'];
  }
}