//
//  ContinueButton.swift
//  Trinity_iOS
//
//  Created by Park Seyoung on 3/30/25.
//

import SwiftUI

enum ContinueButtonStyle {
    case black
    case blackDis
    case ivory
    case ivoryDis
}

extension ContinueButtonStyle {
    var backgroundColor: Color {
        switch self {
        case .black: return Colors.mainSecondary
        case .blackDis: return Colors.mainSecondary
        case .ivory: return Colors.subIvory
        case .ivoryDis: return Colors.subIvory2
        }
    }

    var textColor: Color {
        switch self {
        case .black: return Colors.subIvory
        case .blackDis: return Colors.textInfo
        case .ivory: return Colors.mainPrimary
        case .ivoryDis: return Colors.textDisabled
        }
    }

    var isDisabled: Bool {
        switch self {
        case .blackDis, .ivoryDis: return true
        default: return false
        }
    }
}

struct ContinueButton: View {
    var title: String
    var style: ContinueButtonStyle
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(Fonts.buttonTitle)
                .foregroundColor(style.textColor)
                .padding()
                .frame(maxWidth: .infinity)
                .background(style.backgroundColor)
        }
        .disabled(style.isDisabled)
        .padding(.horizontal, 24)
        .frame(height: 48)
    }
}
