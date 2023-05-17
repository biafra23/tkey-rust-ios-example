import SwiftUI
import CustomAuth

@main
struct tkey_iosApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(vm: LoginModel())
                .onOpenURL { url in
                    print(url)
                    CustomAuth.handle(url: url)
                }
        }
    }
}
