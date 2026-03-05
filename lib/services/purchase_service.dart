import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import '../services/premium_manager.dart';

class PurchaseService {

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;

  static const Set<String> _productIds = {
    'scamkavatch.premium.monthly',
    'scamkavatch.premium.yearly',
  };

  /// Load available subscription products from Apple / Google
  Future<List<ProductDetails>> loadProducts() async {

    final ProductDetailsResponse response =
        await _inAppPurchase.queryProductDetails(_productIds);

    if (response.notFoundIDs.isNotEmpty) {
      debugPrint("Products not found: ${response.notFoundIDs}");
    }

    return response.productDetails;
  }

  /// Start subscription purchase
  Future<void> buy(ProductDetails product) async {

    final PurchaseParam purchaseParam =
        PurchaseParam(productDetails: product);

    await _inAppPurchase.buyNonConsumable(
      purchaseParam: purchaseParam,
    );
  }

  /// Listen for successful purchases
  void listenPurchases(PremiumManager premiumManager) {

    _inAppPurchase.purchaseStream.listen((purchaseDetailsList) {

      for (var purchase in purchaseDetailsList) {

        if (purchase.status == PurchaseStatus.purchased ||
            purchase.status == PurchaseStatus.restored) {

          premiumManager.setPremium(true);
        }

        if (purchase.pendingCompletePurchase) {
          _inAppPurchase.completePurchase(purchase);
        }
      }
    });
  }

  /// Restore purchases (required for Apple)
  Future<void> restorePurchases() async {
    await _inAppPurchase.restorePurchases();
  }
}