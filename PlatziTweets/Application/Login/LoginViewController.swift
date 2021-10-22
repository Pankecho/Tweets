import UIKit
import RxSwift
import RxCocoa
import NotificationBannerSwift

public class LoginViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        let view = LoginView()
        self.view = view
        bind(view: view)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func bind(view: LoginView) {
        navigationItem.backBarButtonItem?.title = ""
        navigationItem.title = "Login"
        
        view.loginButton.rx.tap.subscribe(onNext: {
            guard let email = view.emailTextField.text,
                  let password = view.passwordField.text else { return }
            
            let data = LoginRequest(email: email,
                                    password: password)
            
            SN.post(endpoint: Service.login,
                    model: data) { [weak self] (response: SNResultWithEntity<AuthResponse, ErrorResponse>) in
                switch response {
                case .success(_):
                    let homeViewController = HomeViewController()
                    self?.navigationController?.pushViewController(homeViewController,
                                                                   animated: true)
                case .error(let error):
                    NotificationBanner(title: "Error",
                                       subtitle: error.localizedDescription,
                                       style: .danger)
                        .show()
                case .errorResult(let entity):
                    NotificationBanner(title: "Error",
                                       subtitle: entity.error,
                                       style: .warning)
                        .show()
                }
            }
            
        })
        .disposed(by: disposeBag)
    }
}
