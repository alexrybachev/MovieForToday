//
//  MovieCategoryPosterCarouselView.swift
//  MovieForToday
//
//  Created by Alex on 09.01.2024.
//

import SwiftUI
import RemoteImage

struct MovieCategoryPosterCarouselView: View {
    @ObservedObject var homeViewModel: HomeViewModel
    
    @State private var selected = 0
    
    var body: some View {
        VStack {
            TabView(selection: $selected) {
                ForEach(homeViewModel.movieCollection, id: \.name) { collection in
                    NavigationLink {
                        PopularMovieView(viewModel: homeViewModel, slug: collection.name)
                    } label: {
                        RemoteImage(url: URL(string: collection.cover?.url ?? "")!) { image in
                            MovieImageView(
                                image: image,
                                width: Constants.posterWidth,
                                height: Constants.posterHeight,
                                cornerRadius: Constants.posterRadius
                            )
                            .overlay {
                                PosterLabelView(
                                    title: collection.name,
                                    subtitle: "\(collection.moviesCount ?? 0) movies",
                                    spacing: Constants.labelSpacing
                                )
                                .offset(x: Constants.labelXoffset, y: Constants.labelYoffset)
                            }
                        } placeholder: {
                            ProgressView()
                                .frame(
                                    width: Constants.posterHeight,
                                    height: Constants.posterHeight
                                )
                        } errorHandler: { _ in
                            ErrorImageView(
                                systemName: "photo",
                                width: Constants.posterWidth,
                                height: Constants.posterHeight
                            )
                        }
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            PagingIndexView(numberOfItems: 3, selectedTab: $selected)
                .animation(.default, value: selected)
        }
    }
}

// MARK: - Drawing
private extension MovieCategoryPosterCarouselView {
    struct Constants {
        static let posterHeight: CGFloat = 174
        static let posterWidth: CGFloat = .infinity
        static let posterRadius: CGFloat = 16
        static let labelXoffset: CGFloat = -90
        static let labelYoffset: CGFloat = 30
        static let labelSpacing: CGFloat = 16
    }
}

#Preview {
    MovieCategoryPosterCarouselView(homeViewModel: HomeViewModel())
        .background(.customMain)
}
