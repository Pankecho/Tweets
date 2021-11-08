import Foundation
import UIKit
import PureLayout

public class CreateTweetView: UIView {
    private let titleLabel = UILabel()
    public let closeButton = UIButton()
    public let contentTextView = UITextView()
    public let saveButton = UIButton()
    public let contentImageView = UIImageView()
    public let addImageButton = UIButton()
    public let watchVideoButton = UIButton()
    
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
        titleLabel.text = "New Tweet"
        titleLabel.font = .boldSystemFont(ofSize: 20)
        
        closeButton.setImage(UIImage(systemName: "stop"),
                             for: .normal)
        
        contentTextView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.10)
        contentTextView.setCornerRadius(12)
        
        saveButton.setTitle("Save",
                            for: .normal)
        saveButton.backgroundColor = .black
        saveButton.setTitleColor(.white,
                                 for: .normal)
        saveButton.setCornerRadius(25)
        
        contentImageView.setCornerRadius(12)
        contentImageView.contentMode = .scaleAspectFit
        
        addImageButton.setImage(UIImage(systemName: "camera.fill"),
                             for: .normal)
        addImageButton.tintColor = .black
        addImageButton.contentHorizontalAlignment = .left
        
        watchVideoButton.tintColor = .systemGreen
        watchVideoButton.contentHorizontalAlignment = .left
        watchVideoButton.setTitle("Watch video",
                                  for: .normal)
        watchVideoButton.setTitleColor(.black,
                                       for: .normal)
        watchVideoButton.titleLabel?.font = .systemFont(ofSize: UIFont.systemFontSize,
                                                        weight: .medium)
        watchVideoButton.titleEdgeInsets = UIEdgeInsets(top: 0,
                                                        left: 4,
                                                        bottom: 0,
                                                        right: 0)
        watchVideoButton.setImage(UIImage(systemName: "video.fill"),
                                  for: .normal)
        
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.image = UIImage(named: "cityBackground")
        
        backgroundColor = .white
        contentImageView.isHidden = true
        watchVideoButton.isHidden = true
    }
    
    private func layout() {
        let titleStackView = UIStackView(arrangedSubviews: [
            titleLabel,
            closeButton
        ])
        
        titleStackView.axis = .horizontal
        titleStackView.distribution = .equalSpacing
        
        contentTextView.autoSetDimension(.height,
                                         toSize: 120)
        
        saveButton.autoSetDimension(.height,
                                    toSize: 50)
        
        
        contentImageView.autoSetDimension(.height,
                                          toSize: 200)
        
        addImageButton.autoSetDimensions(to: CGSize(width: 32,
                                                    height: 32))
        
        let contentStackView = UIStackView(arrangedSubviews: [
            contentTextView,
            contentImageView,
            addImageButton
        ])
        
        contentStackView.axis = .vertical
        contentStackView.spacing = 4
        
        let mainStackView = UIStackView(arrangedSubviews: [
            titleStackView,
            contentStackView,
            saveButton,
        ])
        
        mainStackView.axis = .vertical
        mainStackView.spacing = 20
        
        addSubview(mainStackView)
        mainStackView.autoPinEdge(toSuperviewEdge: .top,
                                  withInset: 16)
        mainStackView.autoPinEdge(toSuperviewEdge: .left,
                                  withInset: 16)
        mainStackView.autoPinEdge(toSuperviewEdge: .right,
                                  withInset: 16)
        
        addSubview(backgroundImageView)
        backgroundImageView.autoSetDimension(.height,
                                             toSize: 150)
        backgroundImageView.autoPinEdge(toSuperviewEdge: .bottom)
        backgroundImageView.autoPinEdge(toSuperviewEdge: .left)
        backgroundImageView.autoPinEdge(toSuperviewEdge: .right)
    }
    
    public func setupImage(image: UIImage?) {
        if let image = image {
            contentImageView.isHidden = false
            contentImageView.image = image
        }
    }
    
    public func setupVideo(value: Bool) {
        if value {
            watchVideoButton.isHidden = false
        }
    }
}
