//
//  ViewController.swift
//  AppleSignInTest
//
//  Created by Dante Puglisi on 6/26/25.
//

import UIKit
import AuthenticationServices

class ViewController: UIViewController, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {

    private var authorizationButton: ASAuthorizationAppleIDButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            let button = ASAuthorizationAppleIDButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(handleAppleIDButtonPress), for: .touchUpInside)
            view.addSubview(button)
            NSLayoutConstraint.activate([
                button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
            authorizationButton = button
        }
    }

    @objc private func handleAppleIDButtonPress() {
        if #available(iOS 13.0, *) {
            let provider = ASAuthorizationAppleIDProvider()
            let request = provider.createRequest()
            request.requestedScopes = [.fullName, .email]

            let controller = ASAuthorizationController(authorizationRequests: [request])
            controller.delegate = self
            controller.presentationContextProvider = self
            controller.performRequests()
        }
    }

    // MARK: - ASAuthorizationControllerDelegate

    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        // Handle successful authorization
        print("Authorized: \(authorization)")
    }

    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error
        print("Authorization error: \(error.localizedDescription)")
    }

    // MARK: - ASAuthorizationControllerPresentationContextProviding

    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window ?? ASPresentationAnchor()
    }

}

