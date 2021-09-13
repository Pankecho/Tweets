import UIKit
import RxSwift
import RxCocoa

public class SplashViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        let view = SplashView()
        self.view = view
        bind(view: view)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func bind(view: SplashView) {
        view.loginButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.navigationController?
                .pushViewController(LoginViewController(),
                                    animated: true)
        })
        .disposed(by: disposeBag)
        
        view.signupButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.navigationController?
                .pushViewController(SignupViewController(),
                                    animated: true)
        })
        .disposed(by: disposeBag)
    }
}
