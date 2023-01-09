class PharmacyUserModel{
   String? uId;
   String? name;
   String? email;
   String? phone;
   dynamic image;
   bool? isEmailVerified;

  PharmacyUserModel({
   required this.uId,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.isEmailVerified,
  });

  PharmacyUserModel.fromJson(Map<String,dynamic> json)
  {
    uId = json['uId'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String,dynamic> toMap()
  {
    return{
      'uId' : uId,
      'name' : name,
      'email' : email,
      'phone' : phone,
      'image' : image,
      'isEmailVerified' : isEmailVerified
    };
  }



}