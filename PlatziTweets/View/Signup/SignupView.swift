import UIKit
import PureLayout

public class SignupView: UIView {
    public let emailTextField = UITextField()
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
        emailTextField.placeholder = "Email"
        passwordField.placeholder = "Password"
        repeatPasswordField.placeholder = "Repeat Password"
        
        passwordField.isSecureTextEntry = true
        repeatPasswordField.isSecureTextEntry = true
        
        signupButton.setTitle("Signup", for: .normal)
        signupButton.backgroundColor = .black
        signupButton.setTitleColor(.white, for: .normal)
        
        signupButton.layer.cornerRadius = 25
        
        backgroundColor = .white
    }
    
    private func layout() {
        signupButton.autoSetDimension(.height, toSize: 50)
        
        let stackView = UIStackView(arrangedSubviews: [
            emailTextField,
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
