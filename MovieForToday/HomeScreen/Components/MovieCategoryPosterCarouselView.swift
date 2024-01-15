//
//  MovieCategoryPosterCarouselView.swift
//  MovieForToday
//
//  Created by Alex on 09.01.2024.
//

import SwiftUI
import RemoteImage
import Networking

struct MovieCategoryPosterCarouselView<V: View>: View {
    // MARK: - Drawing
    private let posterHeight: CGFloat = 174
    private let posterWidth: CGFloat = .infinity
    private let posterRadius: CGFloat = 16
    private let labelXoffset: CGFloat = -90
    private let labelYoffset: CGFloat = 30
    private let labelSpacing: CGFloat = 16
    
    let movieCollection: [Networking.Collection]
    let destination: (String) -> V
    
    @State private var selected = 0
    
    var body: some View {
        let _ = Self._printChanges()
        VStack {
            TabView(selection: $selected) {
                ForEach(movieCollection, id: \.name) { collection in
                    NavigationLink {
                        destination(collection.slug)
                    } label: {
                        RemoteImage(
                            link: collection.cover?.url ?? "",
                            configure: configure(_:),
                            placeholder: setPlaceholder,
                            errorHandler: setErrorView
                        )
                        .overlay {
                            VStack(alignment: .leading) {
                                Spacer()
                                PosterLabelView(
                                    title: collection.name,
                                    subtitle: "\(collection.moviesCount ?? 0) movies",
                                    spacing: labelSpacing
                                )
                            }
                            .padding([.bottom, .leading])
                        }
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            PagingIndexView(numberOfItems: movieCollection.count, selectedTab: $selected)
                .animation(.default, value: selected)
        }
    }
    
    init(
        _ movieCollection: [Networking.Collection],
        destination: @escaping (String) -> V
    ) {
        self.movieCollection = movieCollection
        self.destination = destination
        self.selected = selected
    }
    
    //MARK: - Private methods
    private func configure(_ image: SwiftUI.Image) -> some View {
        image
            .resizable()
            .scaledToFill()
            .frame(width: posterWidth, height: posterHeight)
            .clipShape(.rect(cornerRadius: posterRadius))
            .padding([.leading, .trailing])
    }
    
    private func setPlaceholder() -> some View {
        ProgressView()
            .frame(
                width: posterHeight,
                height: posterHeight
            )
    }
    
    private func setErrorView(_ error: Error) -> some View {
        ErrorImageView(
            systemName: "photo",
            width: posterWidth,
            height: posterHeight
        )
    }
}

#Preview {
    NavigationView {
        MovieCategoryPosterCarouselView(
            Collection.sample,
            destination: { _ in EmptyView() }
        )
        .background(.customMain)
    }
}


