//
//  UserAuthenticable.swift
//  Bridgefy Test
//
//  Created by Victor Alfonso Barcenas Monreal on 23/09/22.
//

import Foundation

typealias UserAuthenticableResponse = Result<LoginResponse, LoginError>
typealias UserAuthenticableHandler = (UserAuthenticableResponse) -> Void

protocol UserAuthenticable {
    func login(_ user: User, completion: @escaping UserAuthenticableHandler)
}

extension UserAuthenticable {
    func login(_ user: User, completion: @escaping UserAuthenticableHandler) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let username = user.username.lowercased()
            guard username == "challenge@bridgefy.me"
                    && user.password == "P@$$w0rD!" else {
                let errorResponse = LoginError(code: -1,
                                               message: "Invalid credentials")
                completion(.failure(errorResponse))
                return
            }
            let loginResponse = LoginResponse(succeed: true,
                                              token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c")
            completion(.success(loginResponse))
        }
    }
}
