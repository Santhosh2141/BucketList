//
//  ContentView.swift
//  BucketList
//
//  Created by Santhosh Srinivas on 20/09/25.
//

import SwiftUI

struct User: Identifiable, Comparable{
    let id = UUID()
    let nameF: String
    let nameL: String
    
    // less than is the operator to perform. Static means it belons to the User Struct nad not a single object
    static func <(lhs: User, rhs: User) -> Bool{
        lhs.nameL < rhs.nameL
    }
}
struct ContentView: View {
    let values = [1,2,5,3,8,6].sorted()
    let users = [
        User(nameF: "Lewis", nameL: "Hamilton"),
        User(nameF: "Max", nameL: "Verstappen"),
        User(nameF: "Lando", nameL: "Norris"),
        User(nameF: "Oscar", nameL: "Piastri")
    ].sorted()
    // using sorted for this wont work.
    // and for sorting we have to call sorted inside the view evertyime we use. but, in structs its inbuilt cuz Ints are comparable
    var body: some View {
        VStack {
            List(users){ user in
                Text("\(user.nameL), \(user.nameF)")
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
