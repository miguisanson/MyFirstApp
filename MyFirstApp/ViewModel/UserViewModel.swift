//
//  UserViewModel.swift
//  MyFirstApp
//
//  Created by Miguel Sanson on 6/9/26.
//

class UserViewModel {
    private var users: [User] = [
        User(name: "Miguel", age: 21, details: "iOS trainee", imageName: "person.circle"),
        User(name: "Ana", age: 22, details: "Loves UIKit", imageName: "star.circle"),
        User(name: "Ben", age: 23, details: "Practicing tables", imageName: "book.circle")
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
