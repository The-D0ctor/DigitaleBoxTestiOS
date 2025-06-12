//
//  UserItemView.swift
//  DigitaleBoxTestiOS
//
//  Created by Sébastien Rochelet on 11/06/2025.
//


import SwiftUI

struct UserItemView: View {
    var user: User
    
    var body: some View {
        NavigationLink {
            UserDetailsView(user: user)
        } label: {
            HStack {
                AsyncImage(url: URL(string: user.picture.large)) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                } placeholder: {
                    ProgressView()
                }
                .padding(.trailing, 10)
                Text("\(user.name.title) \(user.name.first) \(user.name.last)")
                    .padding(.leading, 10)
                    .foregroundStyle(.accent)
            }
            .padding()
            .frame(height: 125)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background()
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

#Preview {
    UserItemView(user: User(name: User.Name(title: "Mrs", first: "Sara", last: "Mortensen"), gender: "female", picture: User.Picture(large: "https://randomuser.me/api/portraits/women/32.jpg", medium: "https://randomuser.me/api/portraits/med/women/32.jpg", thumbnail: "https://randomuser.me/api/portraits/thumb/women/32.jpg"), email: "sara.mortensen@example.com", dob: User.DateOfBirth(date: "1991-09-12T12:38:53.702Z", age: 33), location: User.Location(street: User.Location.Street(number: 7417, name: "Kornblomstvej"), city: "Billum", state: "Nordjylland", country: "Denmark", postcode: "29122", coordinates: User.Location.Coordinates(latitude: "-45.0001", longitude: "10.1296"), timezone: User.Location.Timezone(offset: "-2:00", description: "Mid-Atlantic")), phone: "80221329", cell: "22411680"))
}
