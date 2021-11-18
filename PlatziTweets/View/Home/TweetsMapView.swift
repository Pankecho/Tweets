import Foundation
import UIKit
import MapKit
import PureLayout

public class TweetsMapView: UIView {
    public let mapView = MKMapView()
    
    init() {
        super.init(frame: .zero)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        mapView.showsUserLocation = true
    }
    
    private func layout() {
        addSubview(mapView)
        mapView.autoPinEdgesToSuperviewEdges()
    }
}
