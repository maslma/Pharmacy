class CartModel{
  late String cartId;
  late  String cartName;
  late  String cartPrice;
  late  int cartQuantity;
  late  String cartImage;

  CartModel({
    required this.cartId,
    required this.cartName,
    required this.cartPrice,
    required this.cartQuantity,
    required this.cartImage,
});

  CartModel.fromJson(Map<String,dynamic> json)
  {
    cartId = json['cartId'];
    cartName= json['cartName'];
    cartPrice= json['cartPrice'];
    cartQuantity= json['cartQuantity'];
    cartImage= json['cartImage'];


  }
  Map<String,dynamic> toMap()
  {
    return{
      'cartId' : cartId,
      'cartName' : cartName,
      'cartPrice' : cartPrice,
      'cartQuantity' : cartQuantity,
      'cartImage' : cartImage,

    };
  }


}
