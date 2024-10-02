//
//  ElevatorButtonStyleModifier.swift
//  ElevatorRequestApp
//
//  Created by Abhishek on 02/10/24.
//

import SwiftUI

struct ElevatorButtonStyleModifier: ViewModifier {
    var backgroundColor: Color = .blue
    var textColor: Color = .white
    var width: CGFloat = 100
    var height: CGFloat = 50
    var font: Font = .system(size: 25, weight: .bold)

    func body(content: Content) -> some View {
        content
            .frame(width: width, height: height) // Set the button frame
            .foregroundColor(textColor) // Set the icon color
            .background(backgroundColor) // Set the button background color
            .cornerRadius(10) // Set the corner radius
            .font(font) // Set the font
    }
}
