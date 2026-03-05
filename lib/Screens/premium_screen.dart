import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../services/premium_manager.dart';
import '../services/purchase_service.dart';

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  final PurchaseService _purchaseService = PurchaseService();
  List<ProductDetails> _products = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final premiumManager =
          Provider.of<PremiumManager>(context, listen: false);

      _purchaseService.listenPurchases(premiumManager);
    });
  }

  Future<void> _loadProducts() async {
    final products = await _purchaseService.loadProducts();

    setState(() {
      _products = products;
    });
  }

  ProductDetails? _getProduct(String id) {
    try {
      return _products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final monthlyProduct =
        _getProduct('scamkavatch.premium.monthly');

    final yearlyProduct =
        _getProduct('scamkavatch.premium.yearly');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Scam Kavatch Premium"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Upgrade to Premium",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            const ListTile(
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text("AI Scam Detection"),
            ),

            const ListTile(
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text("Advanced Scam Protection"),
            ),

            const ListTile(
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text("Ad-Free Experience"),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: monthlyProduct == null
                  ? null
                  : () {
                      _purchaseService.buy(monthlyProduct);
                    },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("₹49 / month"),
            ),

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: yearlyProduct == null
                  ? null
                  : () {
                      _purchaseService.buy(yearlyProduct);
                    },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("₹249 / year (Best Value)"),
            ),

            const SizedBox(height: 20),

            Center(
              child: TextButton(
                onPressed: () {
                  _purchaseService.restorePurchases();
                },
                child: const Text("Restore Purchases"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}