//
//  PopupView.swift
//  Trinity_iOS
//
//  Created by Park Seyoung on 4/11/25.
//

import SwiftUI

struct PopupView: View {
    var title: String
    var text: String
    var buttonText: String
    var style: PopupStyle
    var action: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 32)
            
            Text(title)
                .font(Fonts.popupTitle)
                .foregroundStyle(style.textColor)
            
            Spacer()
                .frame(height: 16)
            
            Text(text)
                .font(Fonts.regularText)
                .foregroundStyle(style.textColor)
            
            Spacer()
                .frame(height: 20)
            
            Button(action: action) {
                ZStack {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(style.backgroundColor)
                    
                    Text(buttonText)
                        .font(Fonts.popupButtonTitle)
                        .foregroundStyle(Colors.subIvory2)
                }
            }
            .frame(width: 168, height: 44)
            
            Spacer()
                .frame(height: 24)
        }
        .frame(width: UIScreen.main.bounds.width - 64)
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .fill(.clear)
                .stroke(style.borderColor, lineWidth: 1)
        )
        .background(
            RoundedRectangle(cornerRadius: 4)
                .fill(Colors.subIvory)
        )
    }
}

enum PopupStyle {
    case normal
    case error
}

extension PopupStyle {
    var backgroundColor: Color {
        switch self {
        case .normal: return Colors.mainPrimary
        case .error: return Colors.semanticRed1
        }
    }
    
    var textColor: Color {
        switch self {
        case .normal: return Colors.mainPrimary
        case .error: return Colors.semanticRed2
        }
    }
    
    var borderColor: Color {
        switch self {
        case .normal: return Colors.borderDefault
        case .error: return Colors.semanticRed2
        }
    }
}
