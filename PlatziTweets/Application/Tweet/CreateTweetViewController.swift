import Foundation
import UIKit
import RxSwift
import NotificationBannerSwift
import JGProgressHUD
import FirebaseStorage

public class CreateTweetViewController: UIViewController, UINavigationControllerDelegate {
    private let disposeBag = DisposeBag()
    
    public init() {
        super.init(nibName: nil,
                   bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        let view = CreateTweetView()
        self.view = view
        bind(view: view)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func bind(view: CreateTweetView) {
        view.closeButton.rx.tap.bind { [weak self]  in
            self?.dismiss(animated: true)
        }
        .disposed(by: disposeBag)
        
        view.addImageButton.rx.tap.bind { [weak self] in
            self?.openCamera()
        }
        .disposed(by: disposeBag)
        
        view.saveButton.rx.tap.bind { [weak self] in
            self?.uploadImage(view: view)
        }
        .disposed(by: disposeBag)
    }
    
    private func openCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.cameraFlashMode = .off
        imagePicker.cameraCaptureMode = .photo
        imagePicker.allowsEditing = true
        
        imagePicker.delegate = self
        
        present(imagePicker,
                animated: true)
    }
    
    private func uploadImage(view: CreateTweetView) {
        if let image = view.contentImageView.image,
           let imageData = image.jpegData(compressionQuality: 0.1) {
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpg"
            
            let storage = Storage.storage()
            
            let imageName = imageData.base64EncodedString()
            
            let reference = storage.reference(withPath: "platzi-tweets-photo/\(imageName).jpg")
            
            DispatchQueue.global(qos: .background).async {
                reference.putData(imageData,
                                  metadata: metadata) { (_, error) in
                    if let error = error {
                        NotificationBanner(title: "Error",
                                           subtitle: error.localizedDescription,
                                           style: .danger)
                            .show()
                        return
                    }
                    
                    DispatchQueue.main.async {
                        reference.downloadURL { [weak self] (url, err) in
                            self?.uploadTweet(view: view,
                                             imageURL: url?.absoluteString)
                        }
                    }
                }
            }
        }
        uploadTweet(view: view)
    }
    
    private func uploadTweet(view: CreateTweetView,
                             imageURL: String? = nil) {
        guard let text = view.contentTextView.text else { return }
        
        let data = PostRequest(text: text,
                               imageURL: imageURL,
                               videoURL: nil,
                               location: nil)
        
        let hud = JGProgressHUD()
        hud.show(in: view)
        
        SN.post(endpoint: Service.posts,
                model: data) { [weak self] (response: SNResultWithEntity<Post, ErrorResponse>) in
            hud.dismiss()
            
            switch response {
            case .success(_):
                self?.dismiss(animated: true)
                
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

extension CreateTweetViewController: UIImagePickerControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let view = view as? CreateTweetView,
              let image = info[.originalImage] as? UIImage else { return }
        
        view.setupImage(image: image)
    }
}
