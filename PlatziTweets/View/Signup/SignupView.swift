import UIKit
import PureLayout

public class SignupView: UIView {
    public let emailTextField = UITextField()
    public let namesTextField = UITextField()
    public let passwordField = UITextField()
    public let repeatPasswordField = UITextField()
    public let signupButton = UIButton()
    
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
        namesTextField.borderStyle = .roundedRect
        passwordField.borderStyle = .roundedRect
        repeatPasswordField.borderStyle = .roundedRect
        
        emailTextField.placeholder = "Email"
        namesTextField.placeholder = "Name"
        passwordField.placeholder = "Password"
        repeatPasswordField.placeholder = "Repeat Password"
        
        emailTextField.autocorrectionType = .no
        emailTextField.autocapitalizationType = .none
        passwordField.isSecureTextEntry = true
        repeatPasswordField.isSecureTextEntry = true
        
        signupButton.setTitle("Signup", for: .normal)
        signupButton.backgroundColor = .black
        signupButton.setTitleColor(.white, for: .normal)
        
        signupButton.setTitleColor(.gray, for: .disabled)
        
        signupButton.layer.cornerRadius = 25
        
        backgroundColor = .white
    }
    
    private func layout() {
        emailTextField.autoSetDimension(.height, toSize: 40)
        namesTextField.autoSetDimension(.height, toSize: 40)
        passwordField.autoSetDimension(.height, toSize: 40)
        repeatPasswordField.autoSetDimension(.height, toSize: 40)
        signupButton.autoSetDimension(.height, toSize: 50)
        
        let stackView = UIStackView(arrangedSubviews: [
            emailTextField,
            namesTextField,
            passwordField,
            repeatPasswordField,
            signupButton
        ])
        
        stackView.axis = .vertical
        stackView.spacing = 20
        
        addSubview(stackView)
        stackView.autoPinEdge(toSuperviewMargin: .top, withInset: 20)
        stackView.autoPinEdge(.left, to: .left, of: self, withOffset: 20)
        stackView.autoPinEdge(.right, to: .right, of: self, withOffset: -20)
    }
}
