import UIKit
import Flutter
import Firebase
import GoogleMaps
import UserNotifications
import StoreKit

@main
@objc class AppDelegate: FlutterAppDelegate {

  lazy var flutterEngine = FlutterEngine(name: "my_engine")

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    FirebaseApp.configure()
    UNUserNotificationCenter.current().delegate = self

    // 🔥 Start Flutter engine
    flutterEngine.run()

    // 🔥 Attach controller to engine
    let controller = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)

    self.window = UIWindow(frame: UIScreen.main.bounds)
    self.window?.rootViewController = controller
    self.window?.makeKeyAndVisible()

    GeneratedPluginRegistrant.register(with: self)

    return true
  }
}