//
//  SignupBaseView.swift
//  Trinity_iOS
//
//  Created by Park Seyoung on 3/30/25.
//

import SwiftUI
import Combine

private struct ContentHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = 0.0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

struct SignupBaseView<Field: Hashable, Content: View>: View{
    var focusedField: FocusState<Field?>.Binding?
    var progress: CGFloat
    var title: String
    var subTitle: String
    var buttonTitle: String
    var style: ContinueButtonStyle
    var action: () -> Void
    var backbutton: Bool
    
    let content: () -> Content
    @State private var keyboardHeight: CGFloat = 0
    @State private var contentHeight: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                ScrollViewReader { proxy in
                    ScrollView(showsIndicators: false) {
                        contentView(proxy: proxy, geometry: geometry)
                    }
                    .scrollBounceBehavior(.basedOnSize)
                    .ignoresSafeArea(edges: .bottom)
                }
            }
        }
        .onReceive(Publishers.keyboardHeight) { height in
            withAnimation {
                self.keyboardHeight = height
            }
        }
        .background(
            Colors.mainPrimary
        )
    }
    
    private func contentView(proxy: ScrollViewProxy, geometry: GeometryProxy) -> some View {
        VStack(alignment: .center) {
            Color.clear
                    .frame(height: 1)
                    .id("top")
            
            ZStack {
                if backbutton {
                    backButtonView
                        .padding(.top, 24)
                }
                
                progressBar
                    .padding(.top, 24)
            }
            
            titleView
                .padding(.top, 44)
            
            ZStack(alignment: .top) {
                roundedBackgroundView
                    .ignoresSafeArea(.all)
                
                VStack {
                    subTitleView
                        .padding(.top, 28)

                    content()
                        .padding(.top, 36)

                    ContinueButton(title: buttonTitle, style: style, action: action)
                        .padding(.bottom, 60)
                }
            }
            .padding(.top, 36)
        }
        .background(
            GeometryReader { geo in
                Color.clear
                    .preference(key: ContentHeightKey.self, value: geo.size.height)
            }
        )
        .onPreferenceChange(ContentHeightKey.self) { height in
            self.contentHeight = height
        }
        .frame(minHeight: max(contentHeight, geometry.size.height + geometry.safeAreaInsets.bottom))
        .onChange(of:  focusedField?.wrappedValue) { newField in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation {
                    if let newField {
                        proxy.scrollTo(newField, anchor: .bottom)
                    } else {
                        proxy.scrollTo("top", anchor: .top)
                    }
                }
            }
        }
    }
    
    private var backButtonView: some View {
        @Environment(\.dismiss) var dismiss

        return HStack {
            Button(action: {
                dismiss()
            }) {
                Image("backButton")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            .padding(.leading, 28)

            Spacer()
        }
    }
    
    private var progressBar: some View {
        HStack {
            Spacer()
            ProgressView(value: progress)
                .frame(width: 120)
                .tint(Colors.subIvory2)
            Spacer()
        }
    }
    
    private var titleView: some View {
        HStack {
            Spacer()
            
            Text(title)
                .font(Fonts.baseViewTitle)
                .foregroundStyle(Colors.subIvory)
                .multilineTextAlignment(.trailing)
                .padding(.trailing, 24)
        }
        
    }
    
    private var subTitleView: some View {
        Text(subTitle)
            .font(Fonts.baseViewSubTitle)
            .foregroundStyle(Colors.borderDefault)
            .multilineTextAlignment(.center)
    }
    
    private var roundedBackgroundView: some View {
        Colors.subIvory
            .clipShape(
                RoundedCorner(radius: 96, corners: [.topLeft])
            )
    }
}
