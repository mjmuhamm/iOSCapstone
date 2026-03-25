//
//  ContentView.swift
//  iOSCapstone
//
//  Created by Malik Muhammad on 3/24/26.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = FlickrViewModel(networkManager: NetworkManager())

    var body: some View {
        NavigationStack {
            switch viewModel.viewState {
            case .loading:
                ProgressView()
            case .loaded(let flickrModel):
                loadList(list: flickrModel)
            case .apiError(let error):
                Text("Error: \(error.localizedDescription)")
            case .empty:
                EmptyView()
            }
        }
        .onAppear {
            viewModel.getInfo()
        }
        .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
        .refreshable {
            viewModel.getInfo()
        }
    }
    
    @ViewBuilder
    func loadList(list: FlickrModel) -> some View {
        List(list.items) { item in
            FlickrCell(flickrItem: item)
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Flickr Feed")
        .navigationSubtitle("Please separate all tags with a comma")
    }
}

#Preview {
    MainView()
}
