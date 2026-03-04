import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/premium_manager.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Scam Kavatch Premium"),
        backgroundColor: Colors.red.shade700,
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
              onPressed: () {

                // temporary premium activation
                context.read<PremiumManager>().setPremium(true);

              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("₹49 / month"),
            ),

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: () {

                context.read<PremiumManager>().setPremium(true);

              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("₹249 / year (Best Value)"),
            ),

          ],
        ),
      ),
    );
  }
}