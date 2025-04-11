//
//  PhoneAuthViewController.swift
//  Trinity_iOS
//
//  Created by Park Seyoung on 4/11/25.
//

import UIKit
import FirebaseAuth

final class PhoneAuthViewController: UIViewController {
    var phoneNumber: String = ""
    var onVerificationCompleted: ((String) -> Void)?
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let statusLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .overFullScreen
        self.view.backgroundColor = UIColor.mainPrimary.withAlphaComponent(0.2)
        
        setupLoadingUI()
        startVerification()
    }

    private func setupLoadingUI() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.text = "Sending verification code..."
        statusLabel.font = UIFont(name: "Pretendard-Regular", size: 16)
        statusLabel.textColor = .borderAct
        
        view.addSubview(activityIndicator)
        view.addSubview(statusLabel)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            statusLabel.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 16),
            statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    private func startVerification() {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { [weak self] verificationID, error in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
            }
            
            if let error = error {
                print("❌ 인증 실패: \(error.localizedDescription)")
                self?.dismiss(animated: true)
                return
            }
            
            if let verificationID = verificationID {
                print("✅ 인증 성공: verificationID = \(verificationID)")
                self?.onVerificationCompleted?(verificationID)
                self?.dismiss(animated: true)
            }
        }
    }
}
