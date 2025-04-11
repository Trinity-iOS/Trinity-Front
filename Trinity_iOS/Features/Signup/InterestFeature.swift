//
//  InterestFeature.swift
//  Trinity_iOS
//
//  Created by Park Seyoung on 4/10/25.
//

import ComposableArchitecture

@Reducer
struct InterestFeature {
    @ObservableState
    struct State: Equatable {
        var phoneNumber: String = ""
    }

    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)  // ✅ 필수
        case nextButtonTapped
        case delegate(Delegate)
        
        enum Delegate: Equatable {
            case didTapNext
        }
    }

    var body: some ReducerOf<Self> {
        BindingReducer()  // ✅ 바인딩 가능하게
        Reduce { state, action in
            switch action {
            case .binding:
                return .none  // 바인딩 변경은 여기서 따로 처리 안 해도 됨
            case .nextButtonTapped:
                print("포토폴리오로 ㅎ")
                return .send(.delegate(.didTapNext))
            case .delegate:
                return .none
            }
        }
    }
}
