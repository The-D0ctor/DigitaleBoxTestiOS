//
//  DigitaleBoxTestiOSApp.swift
//  DigitaleBoxTestiOS
//
//  Created by Sébastien Rochelet on 09/06/2025.
//

import SwiftUI

@main
struct DigitaleBoxTestiOSApp: App {
    @State private var userListViewModel: UsersListViewModel = UsersListViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(userListViewModel)
        }
    }
}
