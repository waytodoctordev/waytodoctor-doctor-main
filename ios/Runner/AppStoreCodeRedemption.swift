import StoreKit

public class AppStoreCodeRedemption: NSObject {
  @objc public static func presentCodeRedemptionSheet() {
    if #available(iOS 14.0, *) {
      DispatchQueue.main.async {
        SKPaymentQueue.default().presentCodeRedemptionSheet();
      }
    } else {
      // Fallback for earlier versions
      print("Code redemption sheet requires iOS 14 or later")
    }
  }
}
