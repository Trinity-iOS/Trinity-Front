//
//  AppFeature.swift
//  Trinity_iOS
//
//  Created by Park Seyoung on 3/30/25.
//

import ComposableArchitecture

@Reducer
struct AppFeature {
    @ObservableState
    struct State {
        @Presents var destination: Destination.State?
        var isLogin: Bool = false
    }
    
    enum Action {
        case destination(PresentationAction<Destination.Action>)
        case didLaunchApp
    }
    
    @Reducer
    enum Destination {
        case login(LoginFeature)
        case signup(SignupFeature)
//        case signup(SignupFeature)
//        case home(HomeFeature)
//        case mypage(MyPageFeature)
//        case discover(DiscoverFeature)
//        case forum(ForumFeature)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didLaunchApp:
                state.destination = .login(LoginFeature.State())
                return .none
                
            case .destination(.presented(.login(.delegate(.loginSucceeded)))):
                state.destination = .signup(SignupFeature.State())
                return .none
                
                // 기타 라우팅 필요 시 여기에 추가
                
            default:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
}
