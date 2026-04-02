import 'package:flutter/material.dart';
import 'cart_screen.dart';

class GroceryApp extends StatelessWidget {
  const GroceryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class Product {
  final String name;
  final String weight;
  final double price;
  final String image;

  Product(this.name, this.weight, this.price, this.image);
}

List<Product> productList = [
  Product("Egg", "1 dozen", 120, "assets/egg.png"),
  Product("Rice", "1 Kg", 80, "assets/rice.png"),
  Product("Milk", "1 L", 100, "assets/milk.png"),
  Product("Chicken", "1 Kg", 180, "assets/chicken.png"),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: const Text("Grocery Store"),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [


            Expanded(
              child: GridView.builder(
                itemCount: productList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  return ProductCard(productList[index]);
                },
              ),
            ),

            const SizedBox(height: 10),

            // Go to Cart Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.shopping_cart),
                label: const Text(
                  "Go to Cart",
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [

          Expanded(
            child: Image.asset(product.image),
          ),

          const SizedBox(height: 8),

          Text(
            product.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),

          Text(
            product.weight,
            style: const TextStyle(color: Colors.grey),
          ),

          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "৳${product.price}",
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),

              IconButton(
                icon: const Icon(Icons.add_circle, color: Colors.green),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Added to Cart")),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}