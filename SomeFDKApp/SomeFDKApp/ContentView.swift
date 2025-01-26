//
//  ContentView.swift
//  SomeFDKApp
//
//  Created by Suryakant Kachhi on 27/01/2025.
//

import SwiftUI
import SomeFDK

@propertyWrapper struct AppState: DynamicProperty {
    @State var path: NavigationPath = .init()
    @State var uiState: SomeFeatureUIState = .init(path: .constant(NavigationPath()), fetchUser: {"Userrr"}, track: {_, _ in })
    
    var wrappedValue: Self {
        get { self }
        set { self = newValue }
    }
}

struct ContentView: View {
    @AppState var appState: AppState
    
    var body: some View {
        start(uiState: _appState.$uiState)
            .onAppear(perform: doSetup)
    }
}

private extension ContentView {
    func doSetup() {
        appState.uiState = .init(path: _appState.$path, fetchUser: {"Userrr"}, track: {_, _ in })
    }
}

#Preview {
    ContentView()
}
