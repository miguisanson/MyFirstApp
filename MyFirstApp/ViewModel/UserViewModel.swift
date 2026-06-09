//
//  UserViewModel.swift
//  MyFirstApp
//
//  Created by Miguel Sanson on 6/9/26.
//

class UserViewModel {
    private var users: [User] = [
        User(name: "Person A", age: 21, details: "iOS trainee", imageName: "PersonA"),
        User(name: "Person B", age: 22, details: "Loves UIKit", imageName: "PersonB"),
        User(name: "Person C", age: 23, details: "Practicing tables", imageName: "PersonC")
    ]

    var numberOfUsers: Int {
        return users.count
    }

    func displayName(row: Int) -> String {
        let user = users[row]
        return "Name: \(user.name)"
    }

    func displayDetails(row: Int) -> String {
        let user = users[row]
        return "Age: \(user.age) - \(user.details)"
    }

    func imageName(row: Int) -> String {
        let user = users[row]
        return user.imageName
    }
}
