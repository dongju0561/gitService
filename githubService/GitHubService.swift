import Foundation
import RxSwift

class GitHubService{
    //static 프로퍼티를 사용함으로써 싱글톤 디자인 패턴을 구현
    static let shared = GitHubService()

    private let baseURL = "https://api.github.com/search/repositories"

    func searchRepositories(query: String) -> Observable<[Repository]> {
        guard let url = URL(string: "\(baseURL)?q=\(query)") else {
            return Observable.error(NSError(domain: "Invalid URL", code: 0, userInfo: nil))
        }

        return URLSession.shared.rx.data(request: URLRequest(url: url))
            .map { data in
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(GitHubSearchResult.self, from: data)
                    return result.items
                } catch {
                    throw error
                }
            }
    }
}
