import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    window                     = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = StartController()
    window?.backgroundColor    = .red
    window?.makeKeyAndVisible()
    
    return true
  }
  
}
