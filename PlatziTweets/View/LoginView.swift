import UIKit
import PureLayout

public class LoginView: UIView {
    public let emailTextField = UITextField()
    public let passwordField = UITextField()
    public let loginButton = UIButton()
    
    init() {
        super.init(frame: .zero)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        emailTextField.placeholder = "Email"
        passwordField.placeholder = "Password"
        passwordField.isSecureTextEntry = true
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .black
        loginButton.setTitleColor(.white, for: .normal)
        
        loginButton.layer.cornerRadius = 25
        
        backgroundColor = .white
    }
    
    private func layout() {
        loginButton.autoSetDimension(.height, toSize: 50)
        
        let stackView = UIStackView(arrangedSubviews: [
            emailTextField,
            passwordField,
            loginButton
        ])
        
        stackView.axis = .vertical
        stackView.spacing = 20
        
        addSubview(stackView)
        stackView.autoPinEdge(toSuperviewMargin: .top, withInset: 20)
        stackView.autoPinEdge(.left, to: .left, of: self, withOffset: 20)
        stackView.autoPinEdge(.right, to: .right, of: self, withOffset: -20)
    }
}
