import Foundation
import UIKit
import RxSwift

public class HomeViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    public init() {
        super.init(nibName: nil,
                   bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        let view = CreateTweetView()
        self.view = view
        bind(view: view)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func bind(view: CreateTweetView) {
        
    }
}
