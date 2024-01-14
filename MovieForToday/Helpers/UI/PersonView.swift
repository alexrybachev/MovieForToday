//
//  PersonView.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 14.01.2024.
//

import SwiftUI
import RemoteImage

struct PersonView: View {
    var moviePerson: MoviePerson
    var isVertical = true
    
    var body: some View {
        if isVertical {
            VStack {
                RemoteImage(link: moviePerson.photo) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 64, height: 64)
                        .clipShape(Circle())
                } placeholder: {
                    ProgressView()
                        .frame(width: 64, height: 64)
                } errorHandler: { _ in
                    ErrorImageView(
                        systemName: "person.circle",
                        width: 64,
                        height: 64
                    )
                }
                
                VStack(alignment: .leading) {
                    Text(moviePerson.name)
                        .foregroundStyle(.textGrey)
                        .font(.custom(.montSemiBold, size: 12))
                        .padding(.bottom, 5)
                }
            }
        } else {
            HStack {
                RemoteImage(link: moviePerson.photo) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                } placeholder: {
                    ProgressView()
                        .frame(width: 40, height: 40)
                }
                
                VStack(alignment: .leading) {
                    Text(moviePerson.name)
                        .foregroundStyle(.textGrey)
                        .font(.custom(.montSemiBold, size: 14))
                        .padding(.bottom, 5)
                    
                    Text(moviePerson.profession)
                        .foregroundStyle(.textGrey)
                        .font(.custom(.montRegular, size: 10))
                }
            }
        }
    }
}

#Preview {
    PersonView(
        moviePerson: MoviePerson(id: 10,
                                 photo: "photo",
                                 name: "name",
                                 profession: "profession")
    )
}
