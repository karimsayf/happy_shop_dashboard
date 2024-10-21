class ProductOrder {
  final String productId;
  final String productName;
  final String productComponents;
  final String productDesc;
  final String productPhoto;
  final String? productColor; // Optional field
  final String? productSize; // Optional field
  final int quantity;
  final double totalPrice;
  final DateTime createdAt;

  ProductOrder({
    required this.productId,
    required this.productName,
    required this.productComponents,
    required this.productDesc,
    required this.productPhoto,
    this.productColor,
    this.productSize,
    required this.quantity,
    required this.totalPrice,
    required this.createdAt,
  });

  // From JSON
  factory ProductOrder.fromJson(Map<String, dynamic> json) {
    return ProductOrder(
      productId: json['productId'],
      productName: json['productName'],
      productComponents: json['productComponents'],
      productDesc: json['productDesc'],
      productPhoto: json['productPhoto'],
      productColor: json['productColor'],
      productSize: json['productSize'],
      quantity: json['quantity'],
      totalPrice: json['totalPrice'].toDouble(),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'productComponents': productComponents,
      'productDesc': productDesc,
      'productPhoto': productPhoto,
      'productColor': productColor,
      'productSize': productSize,
      'quantity': quantity,
      'totalPrice': totalPrice,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}


class Order {
  final String id;
  final List<ProductOrder> products;
  final String userId;
  final String userPhone;
  final String status;
  final String address;
  final String shippingPrice;
  final String totalPrice;
  final double lat;
  final double long;
  final DateTime createdAt;

  Order({
    required this.id,
    required this.products,
    required this.userId,
    required this.userPhone,
    this.status = "PROGRESSING", // Default value
    required this.address,
    required this.shippingPrice,
    required this.totalPrice,
    required this.lat,
    required this.long,
    required this.createdAt,
  });

  // From JSON
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['_id'],
      products: (json['products'] as List)
          .map((i) => ProductOrder.fromJson(i))
          .toList(),
      userId: json['userId'],
      userPhone: json['userPhone'],
      status: json['status'],
      address: json['address'],
      shippingPrice: json['shippingPrice'],
      totalPrice: json['totalPrice'],
      lat: json['lat'].toDouble(),
      long: json['long'].toDouble(),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'products': products.map((product) => product.toJson()).toList(),
      'userId': userId,
      'userPhone': userPhone,
      'status': status,
      'address': address,
      'shippingPrice': shippingPrice,
      'totalPrice': totalPrice,
      'lat': lat,
      'long': long,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
