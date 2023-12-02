//
//  CustomButtonStyle.swift
//  Birthdays
//
//  Created by Аброрбек on 25.11.2023.
//

import Foundation
import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    var isEnabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(isEnabled ? .orange : .gray)
    }
}
