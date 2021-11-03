import Foundation
import UIKit

public extension UIImageView {
    func setCornerRadius(_ value: CGFloat) {
        layer.masksToBounds = false
        layer.cornerRadius = value
    }
}
