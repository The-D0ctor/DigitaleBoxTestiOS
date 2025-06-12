//
//  UserDetailsView.swift
//  DigitaleBoxTestiOS
//
//  Created by Sébastien Rochelet on 11/06/2025.
//

import SwiftUI

struct UserDetailsView: View {
    var user: User
    let formatterFromAPI: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSS'Z'"
        return formatter
    }()
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGray6).ignoresSafeArea()
            VStack {
                VStack {
                    AsyncImage(url: URL(string: user.picture.large)) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .frame(height: 150)
                    } placeholder: {
                        ProgressView()
                    }
                    ScrollView {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Name:")
                                    .font(.title3)
                                    .bold()
                                Text("\(user.name.title) \(user.name.first) \(user.name.last)")
                            }
                            HStack {
                                Text("Gender:")
                                    .font(.title3)
                                    .bold()
                                Text(user.gender.capitalized)
                            }
                            HStack {
                                Text("Email:")
                                    .font(.title3)
                                    .bold()
                                Text(user.email)
                            }
                            HStack {
                                Text("Birthdate:")
                                    .font(.title3)
                                    .bold()
                                Text(formatter.string(from: formatterFromAPI.date(from: user.dob.date) ?? Date()))
                            }
                            HStack {
                                Text("Age:")
                                    .font(.title3)
                                    .bold()
                                Text("\(user.dob.age) ans")
                            }
                            HStack(alignment: .top) {
                                Text("Adress:")
                                    .font(.title3)
                                    .bold()
                                Text("\(user.location.street.number) \(user.location.street.name)\n\(user.location.postcode) \(user.location.city) \(user.location.state) \n\(user.location.country)")
                            }
                            HStack {
                                Text("Latitude:")
                                    .font(.title3)
                                    .bold()
                                Text("\(user.location.coordinates.latitude)")
                            }
                            HStack {
                                Text("Longitude:")
                                    .font(.title3)
                                    .bold()
                                Text("\(user.location.coordinates.longitude)")
                            }
                            HStack(alignment: .top) {
                                Text("Timezone:")
                                    .font(.title3)
                                    .bold()
                                Text("GMT\(user.location.timezone.offset) - \(user.location.timezone.description)")
                            }
                            HStack {
                                Text("Phone Number:")
                                    .font(.title3)
                                    .bold()
                                Text(user.phone)
                            }
                            HStack {
                                Text("Cell Number:")
                                    .font(.title3)
                                    .bold()
                                Text(user.cell)
                            }
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background()
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding()
            }
        }
    }
}

#Preview {
    UserDetailsView(user: User(name: User.Name(title: "Mrs", first: "Sara", last: "Mortensen"), gender: "female", picture: User.Picture(large: "https://randomuser.me/api/portraits/women/32.jpg", medium: "https://randomuser.me/api/portraits/med/women/32.jpg", thumbnail: "https://randomuser.me/api/portraits/thumb/women/32.jpg"), email: "sara.mortensen@example.com", dob: User.DateOfBirth(date: "1991-09-12T12:38:53.702Z", age: 33), location: User.Location(street: User.Location.Street(number: 7417, name: "Kornblomstvej"), city: "Billum", state: "Nordjylland", country: "Denmark", postcode: "29122", coordinates: User.Location.Coordinates(latitude: "-45.0001", longitude: "10.1296"), timezone: User.Location.Timezone(offset: "-2:00", description: "Mid-Atlantic")), phone: "80221329", cell: "22411680"))
}
