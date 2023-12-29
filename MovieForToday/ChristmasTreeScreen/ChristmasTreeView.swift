//
//  ChristmasTreeView.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 23.12.2023.
//

import SwiftUI

struct ChristmasTreeView: View {
    
    @State private var isSpinning = false
    
    @State private var start = Constants.startLevel
    
    var body: some View {
        VStack {
            //Image(systemName: "wand.and.stars.inverse")
            Text("🎁")
                .font(.system(size: 64))
                .hueRotation(.degrees(isSpinning ? 0 : 150))
                .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true).delay(0.5), value: isSpinning)
            
            ForEach(0..<11) { index in
                ChristmasLevelView(
                    isSpinning: $isSpinning,
                    treeLevel: 0, // Constants.offSets[index]
                    color: .red // Constants.colors[index]
                )
            }
            
        }
        .onAppear {
            isSpinning.toggle()
        }
    }
}

#Preview {
    ChristmasTreeView()
}

struct ChristmasLevelView: View {
    @Binding var isSpinning: Bool
    
    let treeLevel: CGFloat
    let color: Color
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 1)
                .gradientBackground(color: color)
            
            ForEach(0..<4) {
                Text("🪅")
                    .hueRotation(.degrees(isSpinning ? Double($0) * 310 : Double($0) * 50))
                    .offset(y: -10)
//                    .rotationEffect(.degrees(Double($0) * -90))
                    .rotationEffect(.degrees(isSpinning ? 0 : -180))
//                    .frame(width: 10, height: 10)
                    .animation(.linear(duration: 1.5).repeatForever(autoreverses: false), value: isSpinning)
            }
            
        }
        .rotation3DEffect(.degrees(60), axis: (x: 1, y: 0, z: 0))
        .offset(y: treeLevel)
    }
}

extension ChristmasTreeView {
    
    struct Constants {
        static let startLevel: CGFloat = -120
        static let stepLevel: CGFloat = 40
        
        static let colors: [Color] = [
            .treeCoral,
            .treePeach,
            .treeLimeGreen,
            .treeGreen,
            .treeAqua,
            .treeSkyBlue,
            .treeLavender,
            .treePurple,
            .treeOlive,
            .treeForest
        ]
        
        static let offSets: [CGFloat] = [
            -160,
             -120,
             -80,
             -40,
             0,
             40,
             80,
             120,
             200
        ]
    }
}
