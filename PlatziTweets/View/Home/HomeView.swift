import Foundation
import UIKit

public class HomeView: UIView {
    public let tweetsTableView = UITableView()
    
    init() {
        super.init(frame: .zero)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
    }
    
    private func layout() {
        addSubview(tweetsTableView)
        tweetsTableView.autoPinEdgesToSuperviewEdges()
    }
}
