import 'package:flutter/services.dart';

class StoreKitBridge {
  static const MethodChannel _channel = MethodChannel('storekit_bridge');

  static Future<void> presentCodeRedemptionSheet() async {
    try {
      print('channel name $_channel');
      
      await _channel.invokeMethod('presentCodeRedemptionSheet');
      
    } catch (e) {
      print('Failed to present code redemption sheet: $e');
    }
  }
}
