import 'Cart_item.dart';

class Global {
  static List<Item> cart = [];

  static double getCartPrice() {
    double sum = 0;
    for (int i = 0; i < cart.length; i++) {
      sum += cart[i].quantity * cart[i].price;
    }
    return sum;
  }
}
