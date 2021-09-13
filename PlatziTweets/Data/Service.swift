public struct Service {
    private static let domain = "https://platzi-tweets-backend.herokuapp.com/api/v1"
    public static let login = Service.domain + "/auth"
    public static let signup = Service.domain + "/register"
    public static let posts = Service.domain + "/posts"
}
