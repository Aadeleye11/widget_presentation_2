import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: OrderPage()));
}

// Food Item
class Food {
  String name;
  int priceCents;
  Food(this.name, this.priceCents);
}

// Customer
class Customer {
  String name;
  List<Food> cart = [];
  Customer(this.name);
}

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});
  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List<Food> menu = [
    Food('Spinach Pizza', 1299),
    Food('Veggie Burger', 799),
    Food('Chicken Parmesan', 1499),
    Food('Caesar Salad', 999),
    Food('Jollof Rice', 1345),
  ];

  List<Customer> customers = [
    Customer('Samiratu'),
    Customer('Abubakar'),
    Customer('Ayomide'),
    Customer('Emmanuel'),
  ];

  // Converts cents to a dollar string like $12.99
  String formatPrice(int cents) {
    return '\$${(cents / 100).toStringAsFixed(2)}';
  }

  // Adds up all prices in a customer's cart
  int getTotal(Customer customer) {
    int total = 0;
    for (Food food in customer.cart) {
      total += food.priceCents;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drag and Drop'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // The food menu
          Expanded(
            child: ListView.builder(
              itemCount: menu.length,
              itemBuilder: (context, index) {
                Food food = menu[index];

                return Draggable<Food>(
                  data: food,
                  // What is shown while dragging
                  childWhenDragging: Text(
                    food.name,
                    style: TextStyle(color: Colors.grey),
                  ),
                  feedback: Material(
                    child: Container(
                      color: Colors.blueAccent,
                      child: Text(
                        food.name,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),

                  // The normal row sitting in the list
                  child: ListTile(
                    title: Text(food.name),
                    subtitle: Text(formatPrice(food.priceCents)),
                  ),
                );
              },
            ),
          ),

          // Bottom half: the customers
          Container(
            color: Colors.black12,
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (Customer customer in customers)
                  DragTarget<Food>(
                    // What the customer drop zone looks like
                    builder: (context, candidateItems, rejectedItems) {
                      return Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: candidateItems.isNotEmpty
                              ? Colors.green
                              : Colors.transparent,
                        ),
                        child: Column(
                          children: [
                            Text(
                              customer.name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(formatPrice(getTotal(customer))),
                            Text('${customer.cart.length} items'),
                          ],
                        ),
                      );
                    },

                    // What happens when food is dropped here
                    onAcceptWithDetails: (details) {
                      setState(() {
                        customer.cart.add(details.data);
                      });
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
