import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PremiumManager extends ChangeNotifier {

  bool _isPremium = false;

  bool get isPremium => _isPremium;

  static const String _premiumKey = "is_premium_user";

  /// Load premium status when app starts
  Future<void> loadPremiumStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isPremium = prefs.getBool(_premiumKey) ?? false;
    notifyListeners();
  }

  /// Set premium status (used after successful purchase)
  Future<void> setPremium(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_premiumKey, value);

    _isPremium = value;
    notifyListeners();
  }

  /// Restore purchase later (Apple / Google billing)
  Future<void> restorePremium() async {
    final prefs = await SharedPreferences.getInstance();
    _isPremium = prefs.getBool(_premiumKey) ?? false;
    notifyListeners();
  }

  /// Reset premium (for testing or expiry)
  Future<void> resetPremium() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_premiumKey);

    _isPremium = false;
    notifyListeners();
  }
}