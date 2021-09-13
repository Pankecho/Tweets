import UIKit

public class SignupViewController: UIViewController {
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        let view = SignupView()
        self.view = view
        bind()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func bind() {
        navigationItem.backBarButtonItem?.title = ""
        navigationItem.title = "Signup"
    }
}
