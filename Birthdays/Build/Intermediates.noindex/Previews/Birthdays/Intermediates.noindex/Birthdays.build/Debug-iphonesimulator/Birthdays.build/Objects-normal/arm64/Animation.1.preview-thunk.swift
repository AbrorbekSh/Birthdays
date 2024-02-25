@_private(sourceFile: "Animation.swift") import Birthdays
import func SwiftUI.__designTimeBoolean
import func SwiftUI.__designTimeInteger
import protocol SwiftUI.PreviewProvider
import func SwiftUI.__designTimeString
import func SwiftUI.__designTimeFloat
import struct SwiftUI.EmptyView
import protocol SwiftUI.View
import SwiftUI

extension ContentView_Previews {
    @_dynamicReplacement(for: previews) private static var __preview__previews: some View {
        #sourceLocation(file: "/Users/shanazarov/Desktop/iOS/Birthdays/Birthdays/Birthdays/Views/Animation.swift", line: 49)
        ContentView()
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    
#sourceLocation()
    }
}

extension ContentView {
    @_dynamicReplacement(for: body) private var __preview__body: some View {
        #sourceLocation(file: "/Users/shanazarov/Desktop/iOS/Birthdays/Birthdays/Birthdays/Views/Animation.swift", line: 16)
        ZStack { // Weather
            
            VStack(alignment: .leading) {
                Text(__designTimeString("#1331.[1].[2].property.[0].[0].arg[0].value.[0].arg[1].value.[0].arg[0].value", fallback: "Wednesday"))
                
                Text(__designTimeString("#1331.[1].[2].property.[0].[0].arg[0].value.[0].arg[1].value.[1].arg[0].value", fallback: "18°"))
                    .font(.system(size: __designTimeInteger("#1331.[1].[2].property.[0].[0].arg[0].value.[0].arg[1].value.[1].modifier[0].arg[0].value.arg[0].value", fallback: 44)))
                    .fontWeight(.thin)
                
                Spacer()
                Image(systemName: __designTimeString("#1331.[1].[2].property.[0].[0].arg[0].value.[0].arg[1].value.[3].arg[0].value", fallback: "cloud.sun.fill"))
                Text(__designTimeString("#1331.[1].[2].property.[0].[0].arg[0].value.[0].arg[1].value.[4].arg[0].value", fallback: "Partly Cloudy"))
                    .frame(width: __designTimeInteger("#1331.[1].[2].property.[0].[0].arg[0].value.[0].arg[1].value.[4].modifier[0].arg[0].value", fallback: 150), height: __designTimeInteger("#1331.[1].[2].property.[0].[0].arg[0].value.[0].arg[1].value.[4].modifier[0].arg[1].value", fallback: 20), alignment: .leading)
                Text(__designTimeString("#1331.[1].[2].property.[0].[0].arg[0].value.[0].arg[1].value.[5].arg[0].value", fallback: "H:21° L:12°"))
                
            }
            .padding()
            .background(weatherBg)
            .cornerRadius(__designTimeInteger("#1331.[1].[2].property.[0].[0].arg[0].value.[0].modifier[2].arg[0].value", fallback: 22))
            .foregroundColor(.white)
            
        }.frame(width: __designTimeInteger("#1331.[1].[2].property.[0].[0].modifier[0].arg[0].value", fallback: 170), height: __designTimeInteger("#1331.[1].[2].property.[0].[0].modifier[0].arg[1].value", fallback: 170), alignment: .leading)
        .rotation3DEffect(.degrees(rotateIn3D ? __designTimeInteger("#1331.[1].[2].property.[0].[0].modifier[1].arg[0].value.arg[0].value.then", fallback: 12) : __designTimeInteger("#1331.[1].[2].property.[0].[0].modifier[1].arg[0].value.arg[0].value.else", fallback: -12)), axis: (x: rotateIn3D ? __designTimeInteger("#1331.[1].[2].property.[0].[0].modifier[1].arg[1].value.[0]", fallback: 90) : __designTimeInteger("#1331.[1].[2].property.[0].[0].modifier[1].arg[1].value.[1]", fallback: -45), y: rotateIn3D ? __designTimeInteger("#1331.[1].[2].property.[0].[0].modifier[1].arg[1].value.[2]", fallback: -45) : __designTimeInteger("#1331.[1].[2].property.[0].[0].modifier[1].arg[1].value.[3]", fallback: -90), z: __designTimeInteger("#1331.[1].[2].property.[0].[0].modifier[1].arg[1].value.[4]", fallback: 0)))
        .animation(Animation.easeInOut(duration: 6).repeatForever(autoreverses: __designTimeBoolean("#1331.[1].[2].property.[0].[0].modifier[2].arg[0].value.modifier[0].arg[0].value", fallback: __designTimeBoolean("#1331.[1].[2].property.[0].[0].modifier[2].arg[0].value.arg[0].value", fallback: true))))
        .onAppear() {
            rotateIn3D.toggle()
        }

    
#sourceLocation()
    }
}

import struct Birthdays.ContentView
import struct Birthdays.ContentView_Previews

