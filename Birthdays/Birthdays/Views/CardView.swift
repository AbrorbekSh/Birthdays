//
//  CardView.swift
//  Birthdays
//
//  Created by Аброрбек on 01.12.2023.
//

import SwiftUI

struct BlackCard: View {
    @State var rotation: CGFloat = 0.0
    @State private var rotateIn3D = false
    @State private var showingPopover = false
    @State private var show = true
    
    private let aiBackground = LinearGradient(
        gradient: Gradient(
            colors: [
                Color(hex: 0x11998E),
                Color(hex: 0x38EF7D)
            ]
        ),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    

    var body: some View {
        
        ZStack {
            Color("colone")
                .ignoresSafeArea()
            VStack {
                    Text("Generate wish using AI")
                        .font(.system(size: 20, weight: .bold))
                        .frame(
                            width: 300,
                            height: 50,
                            alignment: .leading
                        )
                        .padding()
                        .background(aiBackground)
                        .cornerRadius(22)
                        .foregroundColor(.white)
            }
            .listRowBackground(Color.clear)
            .rotation3DEffect(
                .degrees(rotateIn3D ? 6 : -6),
                axis: (
                    x: rotateIn3D ? 90 : -45,
                    y: rotateIn3D ? -45 : -90,
                    z: 0
                )
            )
            .animation(
                Animation.easeInOut(
                    duration: 2
                )
                .repeatForever(autoreverses: true),
                value: UUID()
            )
            .onAppear() {
                rotateIn3D.toggle()
            }
//            RoundedRectangle(cornerRadius: 20, style: .continuous)
//                .frame(width: 300, height: 50)
//                .foregroundColor(Color("col").opacity(0.9))
//                .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 0)
            
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .frame(width: 130, height: 500)
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.7), Color.green.opacity(0.8)]), startPoint: .top, endPoint: .bottom))
                .rotationEffect(.degrees(rotation))
                .mask {
                    RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .stroke(lineWidth: 4)
                    .frame(width: 320, height: 70)
                }
        }
        .preferredColorScheme(.dark)
        .listRowBackground(Color.clear)
        .rotation3DEffect(
            .degrees(rotateIn3D ? 6 : -6),
            axis: (
                x: rotateIn3D ? 90 : -45,
                y: rotateIn3D ? -45 : -90,
                z: 0
            )
        )
        .animation(
            Animation.easeInOut(
                duration: 2
            )
            .repeatForever(autoreverses: true),
            value: UUID()
        )
        .onAppear {
            rotateIn3D.toggle()
            withAnimation(.linear(duration: 3).repeatForever(autoreverses: false)) {
                rotation = 360
            }
        }
    }
}

struct BlackCard_Previews: PreviewProvider {
    static var previews: some View {
        BlackCard()
    }
}
