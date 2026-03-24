//
//  FlickrViewModel.swift
//  iOSCapstone
//
//  Created by Malik Muhammad on 3/24/26.
//

import Foundation
import Combine

enum FlickrListState {
    case loading
    case loaded(FlickrModel)
    case apiError(Error)
    case empty
}

final class FlickrViewModel : ObservableObject {
    
    @Published var viewState: FlickrListState = .loading
    @Published var searchText: String = ""
    
    private var originalModel : FlickrModel? = nil
    private var originalItems : [FlickrItem] = []
    
    private var urlAdditions : String = ""
    
    let networkManager : Network
    var cancellable = Set<AnyCancellable>()
    
    init(networkManager: Network) {
        self.networkManager = networkManager
        searchBinding()
    }
    
    func searchBinding() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .sink { [weak self] searchWord in
                self?.urlAdditions = "&tags=\(searchWord)"
                self?.getInfo()
            }.store(in: &cancellable)
    }
    
  
    
    func getInfo() {
        viewState = .loading
        var url = Constants.BASE_URL
        if urlAdditions != "" {
            url = "\(url)\(urlAdditions)"
        }
        print("urladditions \(url)")
        
        networkManager.getInfo(urlString: url, modelType: FlickrModel.self)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    print("Tasks Completed")
                case .failure(let error):
                    self?.viewState = .apiError(error)
                    print("ViewModel Error: \(error)")
                }
            } receiveValue: { [weak self] response in
                self?.originalModel = response
                self?.viewState = .loaded(response)
                
            }.store(in: &cancellable)

    }
}
