import Foundation
import UIKit
import RxSwift
import NotificationBannerSwift
import JGProgressHUD
import FirebaseStorage
import AVFoundation
import AVKit
import MobileCoreServices
import CoreLocation

public class CreateTweetViewController: UIViewController, UINavigationControllerDelegate {
    private let disposeBag = DisposeBag()
    
    private var videoURL: URL?
    
    private var userLocation: CLLocation?
    
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
        requestLocation()
    }
    
    private func bind(view: CreateTweetView) {
        view.closeButton.rx.tap.bind { [weak self]  in
            self?.dismiss(animated: true)
        }
        .disposed(by: disposeBag)
        
        view.addImageButton.rx.tap.bind { [weak self] in
            self?.selectMedia()
        }
        .disposed(by: disposeBag)
        
        view.watchVideoButton.rx.tap.bind { [weak self] in
            guard let self = self,
                  let videoURL = self.videoURL else { return }
            let avPlayer = AVPlayer(url: videoURL)
            let playerVC = AVPlayerViewController()
            
            playerVC.player = avPlayer
            
            self.present(playerVC,
                    animated: true) {
                playerVC.player?.play()
            }
        }
        .disposed(by: disposeBag)
        
        view.saveButton.rx.tap.bind { [weak self] in
            self?.uploadVideo(view: view)
        }
        .disposed(by: disposeBag)
    }
    
    private func selectMedia() {
        let vc = UIAlertController(title: "Camera",
                                   message: "Choose an option",
                                   preferredStyle: .actionSheet)
        
        vc.addAction(UIAlertAction(title: "Photo",
                                   style: .default, handler: { _ in self.openCamera() }))
        
        vc.addAction(UIAlertAction(title: "Video",
                                   style: .default, handler: { _ in self.openVideo() }))
        
        vc.addAction(.init(title: "Cancel",
                           style: .cancel))
        
        present(vc,
                animated: true)
    }
    
    private func openCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.cameraFlashMode = .off
        imagePicker.allowsEditing = true
        
        imagePicker.delegate = self
        
        present(imagePicker,
                animated: true)
    }
    
    private func openVideo() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.mediaTypes = [kUTTypeMovie as String]
        imagePicker.cameraFlashMode = .off
        imagePicker.cameraCaptureMode = .video
        imagePicker.videoQuality = .typeMedium
        imagePicker.videoMaximumDuration = TimeInterval(5)
        imagePicker.allowsEditing = true
        
        imagePicker.delegate = self
        
        present(imagePicker,
                animated: true)
    }
    
    private func uploadImage(view: CreateTweetView,
                             videoURL: String? = nil) {
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
                                             imageURL: url?.absoluteString,
                                             videoURL: videoURL)
                        }
                    }
                }
            }
        }
        uploadTweet(view: view,
                    videoURL: videoURL)
    }
    
    private func uploadVideo(view: CreateTweetView) {
        if let videoURL = videoURL,
           let videoData = try? Data(contentsOf: videoURL) {
            let metadata = StorageMetadata()
            metadata.contentType = "video/mp4"
            
            let storage = Storage.storage()
            
            let videoName = videoData.base64EncodedString()
            
            let reference = storage.reference(withPath: "platzi-tweets-video/\(videoName).mp4")
            
            DispatchQueue.global(qos: .background).async {
                reference.putData(videoData,
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
                            self?.uploadImage(view: view,
                                              videoURL: url?.absoluteString)
                        }
                    }
                }
            }
        }
        uploadImage(view: view)
    }
    
    private func uploadTweet(view: CreateTweetView,
                             imageURL: String? = nil,
                             videoURL: String? = nil) {
        guard let text = view.contentTextView.text else { return }
        
        var location: Location?
        
        if let userLocation = userLocation {
            location = Location(latitude: userLocation.coordinate.latitude,
                                longitude: userLocation.coordinate.longitude)
        }
        
        let data = PostRequest(text: text,
                               imageURL: imageURL,
                               videoURL: videoURL,
                               location: location)
        
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
    
    private func requestLocation() {
        guard CLLocationManager.locationServicesEnabled() else { return }
        
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension CreateTweetViewController: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager,
                                didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else { return }
        userLocation = lastLocation
    }
}

extension CreateTweetViewController: UIImagePickerControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let view = view as? CreateTweetView else { return }
        
        if let image = info[.originalImage] as? UIImage {
            view.setupImage(image: image)
        }
        
        if let videoURL = info[.mediaURL] as? URL {
            self.videoURL = videoURL
            view.setupVideo(value: true)
        }
    }
}
