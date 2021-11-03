public struct Post: Codable {
    let id: String
    let author: User
    let imageUrl: String?
    let text: String
    let videoUrl: String?
    let location: Location?
    let hasVideo: Bool
    let hasImage: Bool
    let hasLocation: Bool
    let createdAt: String
}

public struct Location: Codable {
    let latitude: Double
    let longitude: Double
}

public struct PostRequest: Codable {
    let text: String
    let imageURL: String?
    let videoURL: String?
    let location: PostLocationRequest?
}

public struct PostLocationRequest: Codable {
    let latitude: Double
    let longitude: Double
}
