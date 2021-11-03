import UIKit
import RxSwift
import RxCocoa
import NotificationBannerSwift
import JGProgressHUD

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
            
            let hud = JGProgressHUD()
            hud.show(in: view)
            
            SN.post(endpoint: Service.signup,
                    model: data) { [weak self] (response: SNResultWithEntity<AuthResponse, ErrorResponse>) in
                hud.dismiss()
                switch response {
                case .success(let user):
                    SimpleNetworking.setAuthenticationHeader(prefix: "",
                                                             token: user.token)
                    self?.saveData(email: email)
                    let homeViewController = HomeViewController()
                    let nvc = UINavigationController(rootViewController: homeViewController)
                    nvc.modalPresentationStyle = .fullScreen
                    self?.present(nvc,
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
    
    private func saveData(email: String) {
        UserDefaults.standard.setValue(email, forKey: "email")
    }
}
