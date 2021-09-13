import UIKit
import PureLayout

public class SplashView: UIView {
    private let backgroundImageView = UIImageView()
    private let backgrounMaskView = UIView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    public let signupButton = UIButton()
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
        backgroundImageView.image = UIImage(named: "splashBackground")
        backgroundImageView.contentMode = .scaleAspectFill
        
        backgrounMaskView.backgroundColor = .black
        backgrounMaskView.alpha = 0.50
        
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.text = "PlatziTweets"
        
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = .white
        descriptionLabel.text = "Biggest iOS dev community"
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.backgroundColor = .white
        loginButton.layer.cornerRadius = 25
        
        signupButton.setTitle("Signup", for: .normal)
        signupButton.setTitleColor(.white, for: .normal)
        signupButton.backgroundColor = .none
    }
    
    private func layout() {
        addSubview(backgroundImageView)
        backgroundImageView.autoPinEdgesToSuperviewEdges()
        
        addSubview(backgrounMaskView)
        backgrounMaskView.autoPinEdgesToSuperviewEdges()
        
        let titleStackView = UIStackView(arrangedSubviews: [
            titleLabel,
            descriptionLabel
        ])
        
        titleStackView.axis = .vertical
        titleStackView.spacing = 8
        
        addSubview(titleStackView)
        titleStackView.autoCenterInSuperview()
        
        loginButton.autoSetDimension(.height, toSize: 50)
        signupButton.autoSetDimension(.height, toSize: 50)
        
        let buttonStackView = UIStackView(arrangedSubviews: [
            loginButton,
            signupButton
        ])
        
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 8
        
        addSubview(buttonStackView)
        buttonStackView.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: -20)
        buttonStackView.autoPinEdge(.left, to: .left, of: self, withOffset: 20)
        buttonStackView.autoPinEdge(.right, to: .right, of: self, withOffset: -20)
    }
}
