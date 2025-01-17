import 'dart:convert';
import 'package:flutter_amazon_clone_bloc/src/data/datasources/api/user_apis.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/order.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/product.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/user.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/voucher.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  final UserApi userApi = UserApi();

  Future<User> getUserDataInitial(var token, bool isShop) async {
    try {
      http.Response res = await userApi.getUserDataInitial(token, isShop);

      if (res.statusCode == 200) {
        User user = isShop
            ? User.fromMapForShop(jsonDecode(res.body))
            : User.fromJson(
                jsonEncode(
                  jsonDecode(res.body),
                ),
              );
        return user;
      } else {
        throw Exception(jsonDecode(res.body)['msg']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<User> getUserData() async {
    try {
      final pref = await SharedPreferences.getInstance();
      final isShop = pref.getBool('is-shop') ?? false;
      http.Response res = await userApi.getUserData(isShop);

      if (res.statusCode == 200) {
        User user = isShop
            ? User.fromMapForShop(jsonDecode(res.body))
            : User.fromJson(
                jsonEncode(
                  jsonDecode(res.body),
                ),
              );
        return user;
      } else {
        throw Exception(jsonDecode(res.body)['msg']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Product>> addToCartFromWishList(
      {required Product product}) async {
    try {
      List<Product> wishList = [];

      http.Response res = await userApi.addToCartFromWishList(product: product);

      if (res.statusCode == 200) {
        for (int i = 0; i < jsonDecode(res.body).length; i++) {
          wishList.add(
            Product.fromJson(
              jsonEncode(
                jsonDecode(res.body)[i],
              ),
            ),
          );
        }
        return wishList;
      } else {
        throw Exception(jsonDecode(res.body)['msg']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<List>> getCart() async {
    try {
      List<Product> cartProducts = [];
      List<int> productQuantity = [];

      http.Response res = await userApi.getCart();

      if (res.statusCode == 200) {
        for (int i = 0; i < jsonDecode(res.body).length; i++) {
          cartProducts.add(
            Product.fromJson(
              jsonEncode(
                jsonDecode(res.body)[i]['product'],
              ),
            ),
          );
          productQuantity.add(
            jsonDecode(res.body)[i]['quantity'],
          );
        }
        return [cartProducts, productQuantity];
      } else {
        throw Exception(jsonDecode(res.body)['msg']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Product>> getCartOnly() async {
    try {
      List<Product> cartProducts = [];

      http.Response res = await userApi.getCart();

      if (res.statusCode == 200) {
        for (int i = 0; i < jsonDecode(res.body).length; i++) {
          cartProducts.add(
            Product.fromJson(
              jsonEncode(
                jsonDecode(res.body)[i]['product'],
              ),
            ),
          );
        }
        return cartProducts;
      } else {
        throw Exception(jsonDecode(res.body)['msg']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<List>> addToCart({required Product product}) async {
    try {
      List<Product> cartProducts = [];
      List<int> productQuantity = [];

      http.Response res = await userApi.addToCart(product: product);

      if (res.statusCode == 200) {
        for (int i = 0; i < jsonDecode(res.body).length; i++) {
          cartProducts.add(
            Product.fromJson(
              jsonEncode(
                jsonDecode(res.body)[i]['product'],
              ),
            ),
          );
          productQuantity.add(jsonDecode(res.body)[i]['quantity']);
        }
        return [cartProducts, productQuantity];
      } else {
        throw Exception(jsonDecode(res.body)['msg']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<List<dynamic>>> removeFromCart({required Product product}) async {
    try {
      List<Product> cartProducts = [];
      List<int> productQuantity = [];

      http.Response res = await userApi.removeFromCart(product: product);

      if (res.statusCode == 200) {
        for (int i = 0; i < jsonDecode(res.body).length; i++) {
          cartProducts.add(
            Product.fromJson(
              jsonEncode(
                jsonDecode(res.body)[i]['product'],
              ),
            ),
          );
          productQuantity.add(jsonDecode(res.body)[i]['quantity']);
        }

        return [cartProducts, productQuantity];
      } else {
        throw Exception(jsonDecode(res.body)['msg']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<List<dynamic>>> deleteFromCart({required Product product}) async {
    try {
      List<Product> cartProducts = [];
      List<int> productQuantity = [];

      http.Response res = await userApi.deleteFromCart(product: product);

      if (res.statusCode == 200) {
        for (int i = 0; i < jsonDecode(res.body).length; i++) {
          cartProducts.add(
            Product.fromJson(
              jsonEncode(
                jsonDecode(res.body)[i]['product'],
              ),
            ),
          );
          productQuantity.add(jsonDecode(res.body)[i]['quantity']);
        }

        return [cartProducts, productQuantity];
      } else {
        throw Exception(jsonDecode(res.body)['msg']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<List<dynamic>>> saveForLater({required Product product}) async {
    try {
      List<Product> cartProducts = [];
      List<int> productQuantity = [];

      http.Response res = await userApi.saveForLater(product: product);
      if (res.statusCode == 200) {
        for (int i = 0; i < jsonDecode(res.body)["cart"].length; i++) {
          cartProducts.add(
            Product.fromJson(
              jsonEncode(
                jsonDecode(res.body)["cart"][i]["product"],
              ),
            ),
          );
          productQuantity.add(
            jsonDecode(res.body)["cart"][i]["quantity"],
          );
        }
        return [cartProducts, productQuantity];
      } else {
        throw Exception(jsonDecode(res.body)['msg']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Product>> getSaveForLater() async {
    try {
      List<Product> saveForLaterProducts = [];

      http.Response res = await userApi.getSaveForLater();

      if (res.statusCode == 200) {
        for (int i = 0; i < jsonDecode(res.body).length; i++) {
          saveForLaterProducts.add(
            Product.fromJson(
              jsonEncode(
                jsonDecode(res.body)[i]['product'],
              ),
            ),
          );
        }
        return saveForLaterProducts;
      } else {
        throw Exception(jsonDecode(res.body)['msg']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<List<dynamic>>> deleteFromLater(
      {required Product product}) async {
    try {
      List<Product> cartProducts = [];
      List<int> productQuantity = [];

      http.Response res = await userApi.deleteFromLater(product: product);
      if (res.statusCode == 200) {
        for (int i = 0; i < jsonDecode(res.body)["cart"].length; i++) {
          cartProducts.add(
            Product.fromJson(
              jsonEncode(
                jsonDecode(res.body)["cart"][i]["product"],
              ),
            ),
          );
          productQuantity.add(
            jsonDecode(res.body)["cart"][i]["quantity"],
          );
        }
        return [cartProducts, productQuantity];
      } else {
        throw Exception(jsonDecode(res.body)['msg']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<List<dynamic>>> moveToCart({required Product product}) async {
    try {
      List<Product> cartProducts = [];
      List<int> productQuantity = [];

      http.Response res = await userApi.moveToCart(product: product);
      if (res.statusCode == 200) {
        for (int i = 0; i < jsonDecode(res.body)["cart"].length; i++) {
          cartProducts.add(
            Product.fromJson(
              jsonEncode(
                jsonDecode(res.body)["cart"][i]["product"],
              ),
            ),
          );
          productQuantity.add(
            jsonDecode(res.body)["cart"][i]["quantity"],
          );
        }
        return [cartProducts, productQuantity];
      } else {
        throw Exception(jsonDecode(res.body)['msg']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<User> saveUserAddress({required String address}) async {
    try {
      http.Response res = await userApi.saveUserAddress(address: address);

      if (res.statusCode == 200) {
        User user = User.fromJson(
          jsonEncode(
            jsonEncode(res.body),
          ),
        );

        return user;
      } else {
        throw Exception(jsonDecode(res.body)['msg']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> placeOrder(
      {required double totalPrice,
      required String address,
      bool paid = false,
      required String payMethod,
      String? voucherCode}) async {
    try {
      http.Response res = await userApi.placeOrder(
          totalPrice: totalPrice,
          voucherCode: voucherCode,
          address: address,
          paid: paid,
          payMethod: payMethod);

      if (res.statusCode == 200) {
        // Order order = Order.fromJson(
        //   jsonEncode(
        //     jsonDecode(res.body),
        //   ),
        // );
        // return order;
      } else {
        throw Exception(jsonDecode(res.body)['msg']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> placeOrderBuyNow(
      {required Product product, required String address}) async {
    try {
      http.Response res =
          await userApi.placeOrderBuyNow(product: product, address: address);

      if (res.statusCode == 200) {
        return true;
      } else {
        throw Exception(jsonDecode(res.body)['msg']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future getVouchers() async {
    try {
      http.Response res = await userApi.getVouchers();

      if (res.statusCode == 200) {
        return jsonDecode(res.body);
      } else {
        throw Exception(jsonDecode(res.body)['msg']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future addVoucher(Voucher vocuher) async {
    try {
      http.Response res = await userApi.addVoucher(vocuher);

      if (res.statusCode == 200) {
        return jsonDecode(res.body);
      } else {
        throw Exception(jsonDecode(res.body)['msg']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future deleteVoucher(String code) async {
    try {
      http.Response res = await userApi.deleteVoucher(code);

      if (res.statusCode == 200) {
        return jsonDecode(res.body);
      } else {
        throw Exception(jsonDecode(res.body)['msg']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
