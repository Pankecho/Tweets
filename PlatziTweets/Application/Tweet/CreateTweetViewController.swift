import Foundation
import UIKit
import RxSwift

public class CreateTweetViewController: UIViewController {
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
        view.closeButton.rx.tap.bind { [weak self]  in
            self?.dismiss(animated: true)
        }
        .disposed(by: disposeBag)
    }
}
