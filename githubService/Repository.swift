import Foundation

struct Repository: Codable {
    let name: String
    let description: String?
    let owner: Owner

    struct Owner: Codable {
        let login: String
        let avatarURL: String

        enum CodingKeys: String, CodingKey {
            case login
            case avatarURL = "avatar_url"
        }
    }
}
