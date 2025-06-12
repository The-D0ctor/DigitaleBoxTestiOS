//
//  User.swift
//  DigitaleBoxTestiOS
//
//  Created by Sébastien Rochelet on 09/06/2025.
//

import Foundation

struct RandomUserResponse: Codable {
    var results: [User]?
    var error: String?
}

struct User: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    
    var name: Name
    var gender: String
    var picture: Picture
    var email: String
    var dob: DateOfBirth
    var location: Location
    var phone: String
    var cell: String
    
    struct Name: Codable, Equatable {
        var title: String
        var first: String
        var last: String
    }
    
    struct Picture: Codable, Equatable {
        var large: String
        var medium: String
        var thumbnail: String
    }
    
    struct DateOfBirth: Codable, Equatable {
        var date: String
        var age: Int
    }
    
    struct Location: Codable, Equatable {
        var street: Street
        var city: String
        var state: String
        var country: String
        var postcode: String
        var coordinates: Coordinates
        var timezone: Timezone
        
        struct Street: Codable, Equatable {
            var number: Int
            var name: String
        }
        
        struct Coordinates: Codable, Equatable {
            var latitude: String
            var longitude: String
        }
        
        struct Timezone: Codable, Equatable {
            var offset: String
            var description: String
        }
        
        init(street: Street, city: String, state: String, country: String, postcode: String, coordinates: Coordinates, timezone: Timezone) {
            self.street = street
            self.city = city
            self.state = state
            self.country = country
            self.postcode = postcode
            self.coordinates = coordinates
            self.timezone = timezone
        }
        
        init(from decoder: any Decoder) throws {
            let container: KeyedDecodingContainer<User.Location.CodingKeys> = try decoder.container(keyedBy: User.Location.CodingKeys.self)
            self.street = try container.decode(User.Location.Street.self, forKey: User.Location.CodingKeys.street)
            self.city = try container.decode(String.self, forKey: User.Location.CodingKeys.city)
            self.state = try container.decode(String.self, forKey: User.Location.CodingKeys.state)
            self.country = try container.decode(String.self, forKey: User.Location.CodingKeys.country)
            if let postcode = try? container.decode(String.self, forKey: User.Location.CodingKeys.postcode) {
                self.postcode = postcode
            } else {
                self.postcode = String(try container.decode(Int.self, forKey: User.Location.CodingKeys.postcode))
            }
            self.coordinates = try container.decode(User.Location.Coordinates.self, forKey: User.Location.CodingKeys.coordinates)
            self.timezone = try container.decode(User.Location.Timezone.self, forKey: User.Location.CodingKeys.timezone)
        }
    }
    
    enum CodingKeys: CodingKey {
        case name
        case gender
        case picture
        case email
        case dob
        case location
        case phone
        case cell
    }
}
