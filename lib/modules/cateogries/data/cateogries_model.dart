class CategoruModel {
  String? name;
  String? image;

  CategoruModel({
    this.name,
    this.image,

  });

  CategoruModel.fromJson(Map<String,dynamic> json)
  {
    name= json['name'];
    image= json['image'];
  }

  Map<String,dynamic> toMap()
  {
    return{
      'name' : name,
      'image' : image,
    };
  }
}