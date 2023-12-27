//
//  Email.swift
//  MovieForToday
//
//  Created by Daniil Kulikovskiy on 12/27/23.
//

import SwiftUI

struct Email: View {
    @State var mail: String
    var body: some View {
        TextField("Enter your @mail", text: $mail)
            .padding(.leading, 16)
            .foregroundStyle(.white)
            .padding(.vertical, 16)
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(mail.isEmpty ? Color(PrimaryColor.mint.rawValue) : Color.gray, lineWidth: 1.0)
                    .opacity(0.3)
                Text("Email")
                    .foregroundStyle(.white)
                    .font(.custom(.montMedium, size: 12))
                    .offset(x: -142, y: -28)
                
            }
            .padding(.horizontal, 16)
    }
}

#Preview {
    Email(mail: "")
}
