import 'package:flutter/material.dart';

/// ======================= HOME SCREEN =======================
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home"), backgroundColor: Colors.green),
      body: Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.shopping_cart),
          label: const Text("Go to Cart"),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CartScreen()),
            );
          },
        ),
      ),
    );
  }
}

/// ======================= CART SCREEN =======================
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int meatQty = 1;
  int fishQty = 1;

  final int meatPrice = 400;
  final int fishPrice = 300;

  int get total => (meatQty * meatPrice) + (fishQty * fishPrice);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "My Cart",
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            // ==================== Meat Item ====================
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18)),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    child: Text("🥩", style: TextStyle(fontSize: 28)),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Fresh Meat",
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text("400 tk / kg",
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 17,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          if (meatQty > 1) {
                            setState(() {
                              meatQty--;
                            });
                          }
                        },
                      ),
                      Text("$meatQty kg",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            meatQty++;
                          });
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ==================== Fish Item ====================
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18)),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    child: Text("🐟", style: TextStyle(fontSize: 28)),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Fresh Fish",
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text("300 tk / kg",
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 17,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          if (fishQty > 1) {
                            setState(() {
                              fishQty--;
                            });
                          }
                        },
                      ),
                      Text("$fishQty kg",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            fishQty++;
                          });
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
            const Spacer(),

            // ==================== Total + Checkout ====================
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(25)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                      Text("$total tk",
                          style: const TextStyle(
                              fontSize: 22,
                              color: Colors.green,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 15),

                  // ==================== Checkout Button ====================
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => OrderSummaryScreen(
                            meatQty: meatQty,
                            fishQty: fishQty,
                            meatPrice: meatPrice,
                            fishPrice: fishPrice,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 55,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Center(
                        child: Text("Checkout Now",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

/// ======================= ORDER SUMMARY SCREEN =======================
class OrderSummaryScreen extends StatefulWidget {
  final int meatQty;
  final int fishQty;
  final int meatPrice;
  final int fishPrice;

  const OrderSummaryScreen({
    super.key,
    required this.meatQty,
    required this.fishQty,
    required this.meatPrice,
    required this.fishPrice,
  });

  @override
  _OrderSummaryScreenState createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  String location = "Dhaka, Banasree, Block B";
  String paymentOption = "Online Payment";

  void editLocation() {
    TextEditingController controller = TextEditingController(text: location);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Location"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Enter new location"),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              setState(() {
                location = controller.text;
              });
              Navigator.pop(context);
            },
            child: const Text("Save"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double fishTotal = widget.fishPrice.toDouble() * widget.fishQty.toDouble();
    double meatTotal = widget.meatPrice.toDouble() * widget.meatQty.toDouble();
    double total = fishTotal + meatTotal;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Order Summary", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Delivery info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Delivery information",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextButton.icon(
                  onPressed: editLocation,
                  icon: const Icon(Icons.edit, size: 18),
                  label: const Text("Edit"),
                )
              ],
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.location_on, color: Colors.green),
                title: const Text("Delivery to"),
                subtitle: Text(location),
              ),
            ),
            const SizedBox(height: 20),

            // Payment
            const Text("Payment Method",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            buildPaymentOption("Online Payment"),
            buildPaymentOption("Cash on delivery"),
            buildPaymentOption("Pos on delivery"),
            const Divider(height: 30),

            // Order details
            buildRow("Fish (${widget.fishPrice} × ${widget.fishQty} kg)", fishTotal),
            buildRow("Meat (${widget.meatPrice} × ${widget.meatQty} kg)", meatTotal),
            const Divider(height: 30, thickness: 1),

            // Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text("৳ ${total.toStringAsFixed(0)}",
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
            const Spacer(),

            // Continue Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {},
                child: const Text("Continue",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildPaymentOption(String title) {
    return RadioListTile<String>(
      value: title,
      groupValue: paymentOption,
      onChanged: (value) {
        setState(() {
          paymentOption = value!;
        });
      },
      title: Text(title),
      activeColor: Colors.green,
    );
  }

  Widget buildRow(String title, double amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16)),
          Text("৳ ${amount.toStringAsFixed(0)}", style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}