import Foundation
import UIKit

public class HomeView: UIView {
    public let tweetsTableView = UITableView()
    public let createButton = UIButton()
    
    init() {
        super.init(frame: .zero)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        tweetsTableView.register(TweetTableViewCell.self,
                                 forCellReuseIdentifier: "tweetCell")
        
        createButton.backgroundColor = .black
        createButton.setTitleColor(.white,
                                   for: .normal)
        createButton.setImage(UIImage(systemName: "UIApplicationShortcutIcon.IconType.add"),
                              for: .normal)
        createButton.setCornerRadius(25)
        
        backgroundColor = .white
    }
    
    private func layout() {
        addSubview(tweetsTableView)
        tweetsTableView.autoPinEdgesToSuperviewEdges()
        
        addSubview(createButton)
        createButton.autoSetDimensions(to: CGSize(width: 50,
                                                  height: 50))
        createButton.autoPinEdge(toSuperviewEdge: .right,
                                 withInset: 20)
        createButton.autoPinEdge(toSuperviewEdge: .bottom,
                                 withInset: 20)
    }
}
