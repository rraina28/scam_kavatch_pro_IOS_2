import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PremiumManager extends ChangeNotifier {

  bool _isPremium = false;

  bool get isPremium => _isPremium;

  static const String _premiumKey = "is_premium_user";

  SharedPreferences? _prefs;

  /// Initialize manager and load premium status
  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    await loadPremiumStatus();
  }

  /// Load premium status when app starts
  Future<void> loadPremiumStatus() async {
    _prefs ??= await SharedPreferences.getInstance();

    _isPremium = _prefs!.getBool(_premiumKey) ?? false;

    notifyListeners();
  }

  /// Set premium status after successful purchase
  Future<void> setPremium(bool value) async {
    _prefs ??= await SharedPreferences.getInstance();

    await _prefs!.setBool(_premiumKey, value);

    _isPremium = value;

    notifyListeners();
  }

  /// Restore purchase status
  Future<void> restorePremium() async {
    _prefs ??= await SharedPreferences.getInstance();

    _isPremium = _prefs!.getBool(_premiumKey) ?? false;

    notifyListeners();
  }

  /// Reset premium (useful for testing)
  Future<void> resetPremium() async {
    _prefs ??= await SharedPreferences.getInstance();

    await _prefs!.remove(_premiumKey);

    _isPremium = false;

    notifyListeners();
  }
}