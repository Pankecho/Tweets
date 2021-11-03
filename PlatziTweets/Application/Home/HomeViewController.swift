import Foundation
import UIKit
import RxSwift
import RxCocoa
import NotificationBannerSwift

public class HomeViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let items = PublishSubject<[Post]>()
    
    public init() {
        super.init(nibName: nil,
                   bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        let view = HomeView()
        self.view = view
        bind(view: view)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        getData()
    }
    
    private func bind(view: HomeView) {
        navigationItem.title = "Tweets"
        
        items.asObservable().bind(to: view.tweetsTableView.rx.items) { tableView, row, item in
            let cell: TweetTableViewCell = tableView.dequeueReusableCell(withIdentifier: "tweetCell",
                                                                         for: IndexPath(row: row,
                                                                                        section: 0)) as! TweetTableViewCell
            cell.setup(author: item.author.names,
                       username: item.author.nickname,
                       imageURL: item.imageUrl,
                       videoURL: item.videoUrl,
                       text: item.text,
                       createdAt: item.createdAt)
            return cell
        }
        .disposed(by: disposeBag)
        
        view.createButton.rx.tap.bind { [weak self] in
            let vc = CreateTweetViewController()
            self?.present(vc,
                          animated: true)
        }
        .disposed(by: disposeBag)
    }
    
    private func getData() {
        SN.get(endpoint: Service.posts) { [weak self] (response: SNResultWithEntity<[Post], ErrorResponse>) in
            switch response {
            case .success(let posts):
                self?.items.onNext(posts)

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
    }
}
