import UIKit
import CoreLocation
import RxSwift
import MapKit

public class TweetsMapViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private var posts: [Post] = []
    
    public init(posts: [Post]) {
        super.init(nibName: nil,
                   bundle: nil)
        self.posts.append(contentsOf: posts)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        let view = TweetsMapView()
        self.view = view
        bind(view: view)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func bind(view: TweetsMapView) {
        navigationItem.title = "Tweets Locations"
        
        posts
            .filter({ $0.location != nil })
            .forEach { item in
                guard let location = item.location else { return }
                let marker = MKPointAnnotation()
                marker.coordinate = CLLocationCoordinate2D(latitude: location.latitude,
                                                           longitude: location.longitude)
                
                marker.title = item.text
                marker.subtitle = item.author.nickname
                
                view.mapView.addAnnotation(marker)
            }
        
        guard let lastItem = posts.last, let location = lastItem.location else { return }
        
        let lastLocation = CLLocationCoordinate2D(latitude: location.latitude,
                                                  longitude: location.longitude)
        
        guard let heading = CLLocationDirection(exactly: 12) else { return }
        
        view.mapView.camera = MKMapCamera(lookingAtCenter: lastLocation,
                                          fromDistance: 30,
                                          pitch: .zero,
                                          heading: heading)
    }
}
