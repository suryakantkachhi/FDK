//
//  SomeFeatureView.swift
//  X
//
//  Created by Suryakant Kachhi on 25/01/2025.
//

import SwiftUI

public struct SomeFeatureUIState {
    var path: Binding<NavigationPath>
    let fetchUser: () async throws -> String
    let track: ((_ screen: String, _ attribute: [String: String]) -> Void)?
    @State var user: String = .init()
    @State var error: Error = ErrorType.none
    
    public init(path: Binding<NavigationPath>, fetchUser: @escaping () -> String, track: ( (_: String, _: [String : String]) -> Void)?) {
        self.path = path
        self.fetchUser = fetchUser
        self.track = track
    }
}

struct SomeFeatureView: View {
    @Binding var uiState: SomeFeatureUIState
    
    var body: some View {
        NavigationStack(path: uiState.path) {
            VStack {
                TextField("SomeOtherFeatureScreen", text: $uiState.user)
                    .padding()
                    .multilineTextAlignment(.center)
                Button("Go to SomeOtherFeatureScreen") {
                    uiState.path.wrappedValue.append(SomeFirstFeatureScreen())
                }
            }
            .task(task)
            .onAppear(perform: analytics)
            .navigationDestination(for: SomeFirstFeatureScreen.self) { $0 }
        }
        
    }
}

extension SomeFeatureView {
    @Sendable
    func task() async {
        do {
            uiState.user = try await uiState.fetchUser()
        } catch {
            uiState.error = error
        }
    }
    
    func analytics() {
        uiState.track?("SomeOtherFeatureScreen", ["some": "attribute"])
    }
}

enum ErrorType: Error {
    case some
    case none
}


#Preview {
    @Previewable @State var truth: SomeFeatureUIState = .init(path: .constant(NavigationPath()), fetchUser: { "Suryakant" }, track: {_, _ in })
    @Previewable @State var path: NavigationPath = .init()
    SomeFeatureView(uiState: $truth)
}
