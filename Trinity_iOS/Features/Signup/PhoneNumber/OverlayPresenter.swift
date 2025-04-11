//
//  OverlayPresenter.swift
//  Trinity_iOS
//
//  Created by Park Seyoung on 4/11/25.
//

import UIKit

enum OverlayPresenter {
    static func presentPhoneAuth(phoneNumber: String, onCompleted: @escaping (String) -> Void) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let root = windowScene.windows.first?.rootViewController else { return }

        let vc = PhoneAuthViewController()
        vc.phoneNumber = phoneNumber
        vc.onVerificationCompleted = onCompleted
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        root.present(vc, animated: true)
    }
}
