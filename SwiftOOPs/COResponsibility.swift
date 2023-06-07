//
//  COResponsibility.swift
//  SwiftOOPs
//
//  Created by Devdutt Jangir on 07/06/23.
//

import Foundation

enum AuthError: LocalizedError {
    case emptyFirstName
    case emptyLastName
    case emptyEmail
    case emptyPassword
    
    var errorDescription: String? {
        switch self {
        case .emptyFirstName:
            return "First Name is Empty"
        case .emptyLastName:
            return "Last Name is Empty"
        case .emptyEmail:
            return "Email is Empty"
        case .emptyPassword:
            return "Password is Empty"
        }
    }
}

protocol Request {
    var firstName: String? { get }
    var lastName: String? { get }
    var email: String? { get }
    var password: String? { get }
    var repeatPassword: String? { get }
}

extension Request {
    var firstName: String? { return nil }
    var lastName: String? { return nil }
    var email: String? { return nil }
    var password: String? { return nil }
    var repeatPassword: String? { return nil }
}

struct LoginRequest: Request {
    var email: String?
    var password: String?
}

struct SignupRequest: Request {
    var firstName: String?
    var lastName: String?
    var email: String?
    var password: String?
}

protocol Handler {
    var next: Handler? { get }
    func handle(_ request: Request) -> LocalizedError?
}

class BaseHandler: Handler {
    var next: Handler?
    init(with handler: Handler? = nil) {
        self.next = handler
    }
    func handle(_ request: Request) -> LocalizedError? {
        return next?.handle(request)
    }
}

class LoginHandler: BaseHandler {
    override func handle(_ request: Request) -> LocalizedError? {
        guard request.email?.isEmpty == false else {
            return AuthError.emptyEmail
        }
        guard request.password?.isEmpty == false else {
            return AuthError.emptyPassword
        }
        return next?.handle(request)
    }
}


class SignupHandler: BaseHandler {
    override func handle(_ request: Request) -> LocalizedError? {
        guard request.firstName?.isEmpty == false else {
            return AuthError.emptyFirstName
        }
        guard request.lastName?.isEmpty == false else {
            return AuthError.emptyLastName
        }
        guard request.email?.isEmpty == false else {
            return AuthError.emptyEmail
        }
        guard request.password?.isEmpty == false else {
            return AuthError.emptyPassword
        }
        return next?.handle(request)
    }
}

protocol BaseAuthHandler {
    var handler: Handler? { get set }
}

class BaseAuthViewController: BaseAuthHandler {
    var handler: Handler?
    init(handler: Handler) {
        self.handler = handler
    }
}

class LoginViewController: BaseAuthViewController {
    func loginButtonSelected() {
        let request = LoginRequest(email: "dev@gmail.com", password: "test1234")
        if let error = handler?.handle(request) {
            print("Login View Controller Went Wrong")
            print(error.errorDescription)
        } else {
            print("Login View Controller Validation Done")
        }
    }
}

class SignupViewController: BaseAuthViewController {
    func signupButtonSelected() {
        let request = SignupRequest(firstName: "dev", lastName: "jangir", email: "dev@gmail.com", password: "1234")
        if let error = handler?.handle(request) {
            print("Signup View Controller Went wrong")
            print(error.errorDescription)
        } else {
            print("SignUp Controller Validation Done")
        }
    }
}

func testChainOfResponsibility() {
    let loginHandler = LoginHandler()
    let loginController = LoginViewController(handler: loginHandler)
    loginController.loginButtonSelected()
    
    let signupHandler = SignupHandler()
    let signUpController = SignupViewController(handler: signupHandler)
    signUpController.signupButtonSelected()
}
