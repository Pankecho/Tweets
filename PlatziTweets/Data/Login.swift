public struct LoginRequest: Codable {
    let email: String
    let password: String
}

public struct AuthResponse: Codable {
    let user: User
    let token: String
}
