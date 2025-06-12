//
//  UsersListViewModel.swift
//  DigitaleBoxTestiOS
//
//  Created by Sébastien Rochelet on 10/06/2025.
//

import Foundation
import Observation

enum UsersListResult {
    case success([User])
    case failure(String)
}

@Observable class UsersListViewModel: ObservableObject {
    var users: [User] = []
    var errorMessage: String?
    var alertIsPresented: Bool = false
    @ObservationIgnored var isRefreshing: Bool = false
    @ObservationIgnored var page: Int = 1
    
    func fetchUsers() async {
        let result = await NetworkService.shared.fetchUsers(page: page)
        switch result {
        case .success(let users):
            if (isRefreshing) {
                self.users.removeAll()
            }
            self.users.append(contentsOf: users)
            self.errorMessage = nil
            self.alertIsPresented = false
        case .failure(let errorMessage):
            self.users.removeAll()
            self.errorMessage = errorMessage
            self.alertIsPresented = true
        }
        isRefreshing = false
    }
}
