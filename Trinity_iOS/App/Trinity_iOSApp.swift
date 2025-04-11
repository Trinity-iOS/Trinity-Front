//
//  Trinity_iOSApp.swift
//  Trinity_iOS
//
//  Created by Park Seyoung on 3/29/25.
//

import ComposableArchitecture
import SwiftUI

@main
struct Trinity_iOSApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            AppView(
                store: Store(initialState: AppFeature.State()) {
                    AppFeature()
                }
            )
//            딥링크용
//            AppView(
//                store: Store(
//                    initialState: AppFeature.State(
//                        destination: .signup(SignupFeature.State())
//                    )
//                ) {
//                    AppFeature()
//                }
//            )
        }
    }
}
                
