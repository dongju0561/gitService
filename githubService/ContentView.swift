import SwiftUI
import RxSwift
import RxCocoa

struct ContentView: View {
    @ObservedObject private var viewModel = ViewModel()

    var body: some View {
        VStack {
            TextField("Search Repositories", text: $viewModel.queryS)
            /*
             touble shooting :viewModel에 'query' BehavoirRelay<String> 프로퍼티 값을 변경 해야함
            */
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            /*
             touble shooting: 동적 컨텐츠를 List에 출력 그러기 위해서는 RandomAccessCollection이 필요
             
            */
            List(viewModel.repositories, id: \.name) { repo in
                VStack(alignment: .leading) {
                    Text(repo.name)
                        .font(.headline)
                    Text(repo.description ?? "No description")
                        .foregroundColor(.secondary)
                    HStack {
                        Text("Owner: \(repo.owner.login)")
                        Spacer()
                        if let url = URL(string: repo.owner.avatarURL),
                           let data = try? Data(contentsOf: url),
                           let image = UIImage(data: data) {
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                    }
                }
                .padding()
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
