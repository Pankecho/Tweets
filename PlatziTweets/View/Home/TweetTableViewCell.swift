import Foundation
import UIKit
import PureLayout
import Kingfisher

public class TweetTableViewCell: UITableViewCell {
    private let userImageView = UIImageView()
    private let nameLabel = UILabel()
    private let userNameLabel = UILabel()
    private let tweetImageView = UIImageView()
    private let tweetContentTextView = UITextView()
    public let watchVideoButton = UIButton()
    private let tweetDateLabel = UILabel()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        selectionStyle = .none
        
        tweetImageView.isHidden = true
        watchVideoButton.isHidden = true
        
        userImageView.backgroundColor = .gray
        
        nameLabel.font = .systemFont(ofSize: UIFont.systemFontSize,
                                     weight: .heavy)
        
        userNameLabel.textColor = .lightGray
        userNameLabel.font = .systemFont(ofSize: UIFont.systemFontSize,
                                         weight: .medium)
        
        tweetDateLabel.textColor = .lightGray
        tweetDateLabel.font = .systemFont(ofSize: UIFont.smallSystemFontSize)
        
        tweetImageView.contentMode = .scaleToFill
        
        tweetContentTextView.isScrollEnabled = false
        tweetContentTextView.isEditable = false
        tweetContentTextView.font = .systemFont(ofSize: UIFont.systemFontSize)
        
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
    }
    
    private func layout() {
        let userNameStackView = UIStackView(arrangedSubviews: [
            nameLabel,
            userNameLabel,
        ])
        
        userNameStackView.axis = .vertical
        userNameStackView.spacing = 2
        
        userImageView.autoSetDimensions(to: CGSize(width: 32,
                                                   height: 32))
        userImageView.setCornerRadius(16)
        
        let userInfoStackView = UIStackView(arrangedSubviews: [
            userImageView,
            userNameStackView,
        ])
        
        userInfoStackView.axis = .horizontal
        userInfoStackView.alignment = .center
        userInfoStackView.spacing = 8
        
        tweetImageView.autoSetDimension(.height, toSize: 200)
        
        let mainStackView = UIStackView(arrangedSubviews: [
            userInfoStackView,
            tweetContentTextView,
            tweetImageView,
            watchVideoButton,
            tweetDateLabel
        ])
        
        mainStackView.axis = .vertical
        mainStackView.spacing = 8
        
        addSubview(mainStackView)
        mainStackView.autoPinEdge(toSuperviewEdge: .top,
                                  withInset: 16)
        mainStackView.autoPinEdge(toSuperviewEdge: .bottom,
                                  withInset: 16)
        mainStackView.autoPinEdge(toSuperviewEdge: .left,
                                  withInset: 16)
        mainStackView.autoPinEdge(toSuperviewEdge: .right,
                                  withInset: 16)
    }
    
    public func setup(author: String,
                      username: String,
                      imageURL: String?,
                      videoURL: String?,
                      text: String,
                      createdAt: String) {
        nameLabel.text = author
        userNameLabel.text = username
        tweetContentTextView.text = text
        tweetDateLabel.text = createdAt
        
        if let videoURL = videoURL,
           !videoURL.isEmpty {
            // Todo
            watchVideoButton.isHidden = false
        }
        
        if let imageURL = imageURL,
           !imageURL.isEmpty {
            tweetImageView.isHidden = false
            tweetImageView.kf.setImage(with: URL(string: imageURL))
        }
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        watchVideoButton.isHidden = true
        tweetImageView.isHidden = true
        tweetImageView.image = nil
    }
}
