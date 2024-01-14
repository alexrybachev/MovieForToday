//
//  CrewLabelsScrollView.swift
//  MovieForToday
//
//  Created by Alex on 11.01.2024.
//

import SwiftUI
import RemoteImage

struct CrewLabelsScrollView: View {
    @Binding var movieModel: MovieModel
    let height: CGFloat
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(movieModel.persons) { person in
                    RemoteImage(link: person.photo) { image in
                        CrewLabelView(
                            image: image,
                            name: person.name,
                            role: person.profession.capitalized
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


//#Preview {
//    CrewLabelsScrollView(movieModel: MovieModel.getMocData(), height: 150)
//        .background(.customMain)
//}
