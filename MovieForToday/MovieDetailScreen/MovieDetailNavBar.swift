//
//  MovieDetailNavBar.swift
//  MovieForToday
//
//  Created by Андрей Бородкин on 27.12.2023.
//

import SwiftUI

func plug() {
    //
}
struct MovieDetailNavBar: View {
        
        var title: String
        var buttonAction: () -> ()
        @Environment(\.dismiss) var dismiss
        
        // MARK: - ViewBuilder items
        @ViewBuilder private var backButton: some View {
            Button {
                dismiss()
            } label: {
                Image(systemName: "arrow.left")
                    .foregroundColor(.textWhiteGrey)
            }
        }
        
        @ViewBuilder private var addListButton: some View {
            Button {
                self.buttonAction()
            } label: {
                Image(systemName: "plus")
                    .foregroundColor(.textWhiteGrey)
            }
        }
        
        // MARK: - View Body
        var body: some View {
            HStack {
                backButton
                
                Spacer()
                
                Text(title)
                    .font(Font.custom("Open Sans", size: 16))
                    .foregroundColor(.textWhiteGrey)
                    .fontWeight(.bold)
                Spacer()
                addListButton
            }
            .padding()
        }
    }

#Preview {
    MovieDetailNavBar(title: "Spider-Man", buttonAction: plug)
        .background(Color.blue)
}
