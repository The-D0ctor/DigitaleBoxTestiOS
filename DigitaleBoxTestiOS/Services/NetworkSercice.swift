//
//  NetworkService.swift
//  DigitaleBoxTestiOS
//
//  Created by Sébastien Rochelet on 10/06/2025.
//

import Foundation
import Alamofire

actor NetworkService {
    private init() {}
    
    static let shared = NetworkService()
    
    func fetchUsers(page: Int = 1) async -> UsersListResult {
        let response = await AF.request("https://randomuser.me/api/?page=\(page)&results=10")
            .validate()
            .serializingDecodable(RandomUserResponse.self)
            .response
        return response.error != nil ? .failure(response.error!.localizedDescription) : response.value!.error != nil ? .failure(response.value!.error!) : .success(response.value!.results!)
    }
}
