import Foundation
import CustomAuth

class LoginModel: ObservableObject {
    @Published var loggedIn: Bool = false
    @Published var isLoading = false
    @Published var navigationTitle: String = ""
    @Published var userData: [String: Any]!

    func setup() async {
        await MainActor.run(body: {
            isLoading = true
            navigationTitle = "Loading"
        })
        await MainActor.run(body: {
            if self.userData != nil {
                loggedIn = true
            }
            isLoading = false
            navigationTitle = loggedIn ? "UserInfo" : "SignIn"
        })
    }

    func loginWithCustomAuth() {
        Task {
            let sub = SubVerifierDetails(loginType: .installed,
                                         loginProvider: .google,
                                         clientId: "500572929132-57dbeqrtq84m5oibve186vfmdd6p5rmh.apps.googleusercontent.com",
                                         verifier: "google-sub-bttr-500572929132",
                                         redirectURL: "com.googleusercontent.apps.500572929132-57dbeqrtq84m5oibve186vfmdd6p5rmh://"

            )
            let tdsdk = CustomAuth(aggregateVerifierType: .singleIdVerifier,
                                   aggregateVerifier: "google-aggregate-bttr",
                                   subVerifierDetails: [sub],
                                   network: .CYAN
            )
            let data = try await tdsdk.triggerLogin()
            await MainActor.run(body: {
                self.userData = data
                dump(data, name: "Data ")
                loggedIn = true
            })
        }
    }

}
