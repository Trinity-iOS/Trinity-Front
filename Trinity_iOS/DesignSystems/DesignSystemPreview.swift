//
//  DesignSystemPreview.swift
//  Trinity_iOS
//
//  Created by Park Seyoung on 3/30/25.
//

import SwiftUI

struct DesignSystemPreview: View {
    
    var body: some View {
        PopupView(title: "바보", text: "흠", buttonText: "next", style: .error, action: {print("너뭐니")})
    }
}

#Preview {
    DesignSystemPreview()
}
