//
//  CrewLabelsScrollView.swift
//  MovieForToday
//
//  Created by Alex on 11.01.2024.
//

import SwiftUI
import RemoteImage

struct CrewLabelsScrollView: View {
    let movieModel: MovieModel
    let height: CGFloat
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                // TODO: временное решение
                ForEach(0..<5) { _ in
                    RemoteImage(url: URL(string: movieModel.urlPoster)!) { image in
                        CrewLabelView(
                            image: image,
                            name: movieModel.name,
                            role: movieModel.genre.first!.name.capitalized
                        )
                    } placeholder: {
                        ProgressView()
                            .frame(
                                width: height,
                                height: height
                            )
                    }
                }
            }
        }
        .padding(.bottom)
    }
}

#Preview {
    CrewLabelsScrollView(movieModel: MovieModel.getMocData(), height: 150)
        .background(.customMain)
}
