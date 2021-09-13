import UIKit

public struct SplashCoordinator {
    private let window: UIWindow
    
    init(w: UIWindow) {
        window = w
    }
    
    public func start() {
        let nvc = UINavigationController(rootViewController: SplashViewController())
        window.rootViewController = nvc
        window.makeKeyAndVisible()
    }
}
