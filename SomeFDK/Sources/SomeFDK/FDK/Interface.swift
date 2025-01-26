//
//  Interface.swift
//  X
//
//  Created by Suryakant Kachhi on 26/01/2025.
//

import SwiftUI

@MainActor public func start(uiState: Binding<SomeFeatureUIState>) -> some View {
    SomeFeatureView(uiState: uiState)
}
