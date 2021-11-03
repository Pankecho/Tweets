import UIKit
import RxSwift
import RxCocoa
import NotificationBannerSwift

public class SignupViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        let view = SignupView()
        self.view = view
        bind(view: view)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func bind(view: SignupView) {
        navigationItem.backBarButtonItem?.title = ""
        navigationItem.title = "Signup"
        
        view.signupButton.rx.tap.subscribe(onNext: { [weak self] in
            guard let email = view.emailTextField.text,
                  let names = view.namesTextField.text,
                  let password = view.passwordField.text else { return }
          
            let data = SignupRequest(email: email,
                                     password: password,
                                     names: names)
            
            SN.post(endpoint: Service.signup,
                    model: data) { [weak self] (response: SNResultWithEntity<AuthResponse, ErrorResponse>) in
                switch response {
                case .success(let user):
                    SimpleNetworking.setAuthenticationHeader(prefix: "",
                                                             token: user.token)
                    let homeViewController = HomeViewController()
                    self?.navigationController?.pushViewController(homeViewController,
                                                                   animated: true)
                case .error(let error):
                    print(error)
                    NotificationBanner(title: "Error",
                                       subtitle: error.localizedDescription,
                                       style: .danger)
                        .show()
                case .errorResult(let entity):
                    print(entity)
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
