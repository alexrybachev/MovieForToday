//
//  CustomBackButton.swift
//  MovieForToday
//
//  Created by Alex on 04.01.2024.
//

import SwiftUI

struct CustomBackButton: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(Color.primaryColor(.softDark))
                .frame(width: 32, height: 32)
                .overlay {
                    Image(.arrowBack)
                }
        }
    }
}

#Preview {
    CustomBackButton()
}
