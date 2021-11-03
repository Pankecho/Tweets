import Foundation
import UIKit

public extension UIView {
    func setCornerRadius(_ value: CGFloat) {
        layer.masksToBounds = false
        layer.cornerRadius = value
    }
}
