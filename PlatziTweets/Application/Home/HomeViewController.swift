import Foundation
import UIKit
import RxSwift
import RxCocoa
import NotificationBannerSwift
import JGProgressHUD
import AVKit
import CoreLocation

public class HomeViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let items = PublishSubject<[Post]>()
    private var posts: [Post] = []
    
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search,
                                                            target: self,
                                                            action: #selector(showMapView))
        
        items.asObservable().bind(to: view.tweetsTableView.rx.items) { tableView, row, item in
            let cell: TweetTableViewCell = tableView
                .dequeueReusableCell(withIdentifier: "tweetCell",
                                     for: IndexPath(row: row,
                                                    section: 0)) as! TweetTableViewCell
            cell.setup(author: item.author.names,
                       username: item.author.nickname,
                       imageURL: item.imageUrl,
                       videoURL: item.videoUrl,
                       text: item.text,
                       createdAt: item.createdAt)
            
            cell.watchVideoButton.rx.tap.asObservable().bind { [weak self] _ in
                guard let self = self,
                      let videoURL = item.videoUrl,
                      let url = URL(string: videoURL)  else { return }
                let avPlayer = AVPlayer(url: url)
                let playerVC = AVPlayerViewController()
                
                playerVC.player = avPlayer
                
                self.present(playerVC,
                        animated: true) {
                    playerVC.player?.play()
                }
            }
            .disposed(by: self.disposeBag)
            
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
        let hud = JGProgressHUD()
        hud.show(in: view)
        SN.get(endpoint: Service.posts) { [weak self] (response: SNResultWithEntity<[Post], ErrorResponse>) in
            hud.dismiss()
            switch response {
            case .success(let posts):
                self?.posts = posts
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
    
    // Todo delete
    private func deletePost(at indexPath: IndexPath) {
    }
    
    @objc private func showMapView() {
        let vc = TweetsMapViewController(posts: posts)
        navigationController?.pushViewController(vc,
                                                 animated: true)
    }
}
