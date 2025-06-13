import 'package:in_app_purchase/in_app_purchase.dart';
import 'ad_service.dart';
import 'dart:async';

class PurchaseService {
  static final PurchaseService _instance = PurchaseService._internal();
  factory PurchaseService() => _instance;
  PurchaseService._internal();

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  final AdService _adService = AdService();
  StreamSubscription<List<PurchaseDetails>>? _subscription;
  List<ProductDetails> _products = [];

  Future<void> initialize() async {
    final bool available = await _inAppPurchase.isAvailable();
    if (!available) return;

    _subscription = _inAppPurchase.purchaseStream.listen(
      _handlePurchaseUpdates,
      onDone: () {
        _subscription?.cancel();
      },
      onError: (error) {
        print('Purchase Error: $error');
      },
    );

    await loadProducts();
  }

  Future<void> loadProducts() async {
    const String premiumId = 'premium_version';
    final ProductDetailsResponse response =
        await _inAppPurchase.queryProductDetails({premiumId});

    if (response.notFoundIDs.isNotEmpty) {
      print('Product not found: ${response.notFoundIDs}');
    }

    _products = response.productDetails;
  }

  Future<void> buyPremium() async {
    if (_products.isEmpty) {
      print('No products available');
      return;
    }

    final PurchaseParam purchaseParam = PurchaseParam(
      productDetails: _products.first,
    );

    try {
      await _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
    } catch (e) {
      print('Purchase Error: $e');
    }
  }

  Future<void> _handlePurchaseUpdates(List<PurchaseDetails> purchaseDetailsList) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        // Satın alma işlemi devam ediyor
      } else if (purchaseDetails.status == PurchaseStatus.error) {
        // Hata oluştu
        print('Purchase Error: ${purchaseDetails.error}');
      } else if (purchaseDetails.status == PurchaseStatus.purchased ||
          purchaseDetails.status == PurchaseStatus.restored) {
        // Satın alma başarılı veya geri yüklendi
        await _adService.setPremium(true);
        await _verifyPurchase(purchaseDetails);
      }

      if (purchaseDetails.pendingCompletePurchase) {
        await _inAppPurchase.completePurchase(purchaseDetails);
      }
    }
  }

  Future<void> _verifyPurchase(PurchaseDetails purchaseDetails) async {
    if (purchaseDetails.productID == 'premium_version') {
      // Satın almayı doğrula ve premium özellikleri aktifleştir
      await _adService.setPremium(true);
    }
  }

  void dispose() {
    _subscription?.cancel();
  }
} 