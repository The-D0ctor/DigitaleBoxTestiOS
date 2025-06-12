//
//  ContentView.swift
//  DigitaleBoxTestiOS
//
//  Created by Sébastien Rochelet on 09/06/2025.
//

import SwiftUI

struct ContentView: View {
    @Environment(UsersListViewModel.self) private var usersListViewModel
    
    var body: some View {
        @Bindable var usersListViewModel = usersListViewModel
        
        NavigationStack {
            ZStack {
                Color(UIColor.systemGray6)
                    .ignoresSafeArea()
                VStack {
                    if (usersListViewModel.errorMessage == nil) {
                        ScrollView {
                            LazyVStack {
                                ForEach(usersListViewModel.users) { user in
                                    UserItemView(user: user)
                                }
                                ProgressView()
                                    .onAppear {
                                        if (!usersListViewModel.isRefreshing) {
                                            Task {
                                                usersListViewModel.page += 1
                                                await usersListViewModel.fetchUsers()
                                            }
                                        }
                                    }
                            }
                        }
                        .refreshable {
                            usersListViewModel.page = 1
                            usersListViewModel.isRefreshing = true
                            await usersListViewModel.fetchUsers()
                        }
                    }
                }
                .padding()
                .task {
                    if (usersListViewModel.users.isEmpty) {
                        await usersListViewModel.fetchUsers()
                    }
                }
                .alert(usersListViewModel.errorMessage ?? "", isPresented: $usersListViewModel.alertIsPresented) {}
            }
        }
    }
}

#Preview {
    ContentView().environment(UsersListViewModel())
}


