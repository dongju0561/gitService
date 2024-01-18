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
            //.debounce: 300밀리초 동안 새로운 입력이 없을 때에만 최근의 입력을 출력으로 방출
            .distinctUntilChanged()
            //.distinctUntilChanged() 메소드는 들어오는 연속적으로 들어오는 값들 중 이전으 값과 중복되면 변경되지 않은 값은 무시하는 메소드입니다.
            .flatMapLatest { query in
                GitHubService.shared.searchRepositories(query: query)
                    .catchErrorJustReturn([])
            }
            //
            .bind(to: repositories)
            .disposed(by: disposeBag)
    }
}
