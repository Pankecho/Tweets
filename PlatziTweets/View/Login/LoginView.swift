import UIKit
import PureLayout

public class LoginView: UIView {
    public let emailTextField = UITextField()
    public let passwordField = UITextField()
    public let loginButton = UIButton()
    private let backgroundImageView = UIImageView()
    
    init() {
        super.init(frame: .zero)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        emailTextField.borderStyle = .roundedRect
        passwordField.borderStyle = .roundedRect
        
        emailTextField.placeholder = "Email"
        emailTextField.textContentType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
        
        passwordField.placeholder = "Password"
        passwordField.isSecureTextEntry = true
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .black
        loginButton.setTitleColor(.white, for: .normal)
        
        loginButton.setTitleColor(.gray, for: .disabled)
        
        loginButton.setCornerRadius(25)
        
        backgroundColor = .white
        
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.image = UIImage(named: "cityBackground")
    }
    
    private func layout() {
        emailTextField.autoSetDimension(.height,
                                        toSize: 40)
        passwordField.autoSetDimension(.height,
                                       toSize: 40)
        loginButton.autoSetDimension(.height,
                                     toSize: 50)
        
        let stackView = UIStackView(arrangedSubviews: [
            emailTextField,
            passwordField,
            loginButton
        ])
        
        stackView.axis = .vertical
        stackView.spacing = 20
        
        addSubview(stackView)
        stackView.autoPinEdge(toSuperviewMargin: .top,
                              withInset: 20)
        stackView.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
        stackView.autoPinEdge(toSuperviewEdge: .right, withInset: 20)
        
        addSubview(backgroundImageView)
        backgroundImageView.autoSetDimension(.height,
                                             toSize: 150)
        backgroundImageView.autoPinEdge(toSuperviewEdge: .bottom)
        backgroundImageView.autoPinEdge(toSuperviewEdge: .left)
        backgroundImageView.autoPinEdge(toSuperviewEdge: .right)
    }
}
