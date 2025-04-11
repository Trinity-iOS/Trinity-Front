//
//  Fonts.swift
//  Trinity_iOS
//
//  Created by Park Seyoung on 3/30/25.
//

import SwiftUI

public enum Fonts {
    public static let mainTitle = Font.custom("Pretendard-Bold", size: 42)
    public static let mainUserId = Font.system(size: 42, weight: .semibold)
    public static let mainInfo = Font.system(size: 42, weight: .semibold)
    
    public static let buttonTitle = Font.custom("Pretendard-SemiBold", size: 24)
    
    public static let baseViewTitle = Font.custom("Moderniz", size: 20)
    public static let baseViewSubTitle = Font.custom("Pretendard-Medium", size: 14)
    
    public static let baseViewTextFieldTitle = Font.custom("Pretendard-Regular", size: 14)
    
    public static let regularText = Font.custom("Pretendard-Regular", size: 16)
    
    public static let mediumText = Font.custom("Pretendard-SemiBold", size: 36)
    
    public static let popupTitle = Font.custom("Pretendard-Bold", size: 24)
    public static let popupButtonTitle = Font.custom("Pretendard-SemiBold", size: 16)

    public static let caption = Font.system(size: 12, weight: .light)
}
