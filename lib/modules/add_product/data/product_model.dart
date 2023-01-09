class productModel{
   String? productId;
  String? productimage;
 String? productname;
  String? pills;
  String? price;
  String? details;


  productModel({
    required this.productId,
  required  this.productimage,
  required  this.productname,
  required  this.price,
  required  this.pills,
  required  this.details,

  });
  productModel.fromJson(Map<String,dynamic> json)
  {
    productId=json['productId'];
    productimage= json['productimage'];
    productname= json['productname'];
    price= json['price'];
    pills= json['pills'];
    details= json['details'];


  }
  Map<String,dynamic> toMap()
  {
    return{
      'productId' : productId,
      'productimage' : productimage,
      'productname' : productname,
      'price' : price,
      'pills' : pills,
      'details' : details,

    };
  }

}