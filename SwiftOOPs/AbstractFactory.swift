//
//  AbstractFactory.swift
//  SwiftOOPs
//
//  Created by Devdutt Jangir on 31/05/23.
//

import Foundation

enum AuthType {
    case login
    case signup
}

protocol AuthViewFactory {
    static func authView(for type: AuthType) -> AuthView
    static func authController(for type: AuthType) -> AuthViewController
}

class StudentAuthViewFactory: AuthViewFactory {
    static func authView(for type: AuthType) -> AuthView {
        print("Student View Created")
        switch type {
            case .login: return StudentLoginView()
            case .signup: return StudentSignUpView()
        }
    }
    
    static func authController(for type: AuthType) -> AuthViewController {
        let controller = StudentAuthViewController(contentView: authView(for: type))
        print("Student View Controller created")
        return controller
    }
}

class TeacherAuthViewFactory: AuthViewFactory {
    static func authView(for type: AuthType) -> AuthView {
        print("Teacher view created")
        switch type {
            case .login: return TeacherLoginView()
            case .signup: return TeacherSignUpView()
        }
    }
    
    static func authController(for type: AuthType) -> AuthViewController {
        let controller = TeacherAuthViewController(contentView: authView(for: type))
        print("Teacher view controller")
        return controller
    }
}

class UIView {}

protocol AuthView {
    var contentView: UIView { get }
    var description: String { get }
}

class StudentSignUpView: AuthView {
    var contentView = UIView()
    var description: String {
        return "Student Signup view"
    }
}

class StudentLoginView: AuthView {
    var contentView = UIView()
    var description: String {
        return "Student Login view"
    }
}

class TeacherSignUpView: AuthView {
    var contentView = UIView()
    var description: String {
        return "Teacher Signup view"
    }
}

class TeacherLoginView: AuthView {
    var contentView = UIView()
    var description: String {
        return "Teacher Login view"
    }
}

class AuthViewController {
    fileprivate var contentView: AuthView
    init(contentView: AuthView) {
        self.contentView = contentView
    }
}

class StudentAuthViewController: AuthViewController {
}

class TeacherAuthViewController: AuthViewController {
}

private class ClientAbstractFactoryCode {
    private var currentViewController: AuthViewController?
    private let factoryType: AuthViewFactory.Type
    init(factoryType: AuthViewFactory.Type) {
        self.factoryType = factoryType
    }
    
    func presentLogin() {
        let _ = factoryType.authController(for: .login)
        print("present login for \(factoryType.authView(for: .login).description)")
    }
    
    func presentSignUp() {
        let _ = factoryType.authController(for: .signup)
        print("present signup for \(factoryType.authView(for: .login).description)")
    }
}

func testAbstractFactory() {
    let teacherClientCode = ClientAbstractFactoryCode(factoryType: TeacherAuthViewFactory.self)
    let studentClientCode = ClientAbstractFactoryCode(factoryType: StudentAuthViewFactory.self)
    teacherClientCode.presentLogin()
    studentClientCode.presentSignUp()
}
 
