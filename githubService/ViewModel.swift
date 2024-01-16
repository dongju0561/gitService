import Foundation
import RxSwift
import RxCocoa
import Combine

class ViewModel : ObservableObject{
    var query = BehaviorRelay<String>(value: "")
    var queryS: String = ""
    var repositories = BehaviorRelay<[Repository]>(value: [])
    private let disposeBag = DisposeBag()

    init() {
        query
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { query in
                GitHubService.shared.searchRepositories(query: query)
                    .catchErrorJustReturn([])
            }
            .bind(to: repositories)
            .disposed(by: disposeBag)
    }
}
