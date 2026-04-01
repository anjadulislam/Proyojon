import 'package:flutter/material.dart';
import 'cart_screen.dart';


class Product {
  final String name;
  final String weight;
  final double price;
  final String image;

  Product(this.name, this.weight, this.price, this.image);
}

List<Product> productList = [
  Product("Egg", "1 dozen", 120, "assets/egg.png"),
  Product("Rice", "1 Kg", 80, "assets/Rice.png"),
  Product("Milk", "1 L", 100, "assets/milk.png"),
  Product("Chicken", "1000 Gm", 180, "assets/chicken.png"),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> filteredList = productList;
  TextEditingController searchController = TextEditingController();
  int _selectedIndex = 0;

  void searchProduct(String query) {
    final results = productList.where((product) {
      return product.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredList = results;
    });
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      // Navigate to CartScreen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CartScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTap,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Account"),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined, color: Colors.white),
                        SizedBox(width: 5),
                        Text(
                          "DHAKA, Bangladesh",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=3"),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: searchController,
                onChanged: searchProduct,
                decoration: InputDecoration(
                  hintText: "Search products...",
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Products",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: GridView.builder(
                  itemCount: filteredList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) {
                    final product = filteredList[index];
                    return ProductCard(product);
                  },
                ),
              ),
            ],
          ),
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductDetailsScreen(product)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Center(child: Image.asset(product.image))),
              const SizedBox(height: 10),
              Text(product.name,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text(product.weight, style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("\৳${product.price}",
                      style: const TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16)),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.add, color: Colors.white),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Added to Cart")));
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name), backgroundColor: Colors.green),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset(product.image, height: 200)),
            const SizedBox(height: 20),
            Text(product.name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text(product.weight, style: const TextStyle(color: Colors.grey, fontSize: 16)),
            const SizedBox(height: 10),
            Text("৳${product.price}",
                style: const TextStyle(
                    fontSize: 22, color: Colors.green, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Text(
              "This is a high quality ${product.name}. Fresh and organic grocery product.",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}