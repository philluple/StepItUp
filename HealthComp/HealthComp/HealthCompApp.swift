import SwiftUI
import FirebaseCore
import Firebase

@main
struct HealthCompApp: App {
    init() {
        FirebaseApp.configure()
    }
    @StateObject var imageUtil = ImageUtilObservable()
    @StateObject var userModel = UserVM()
    @StateObject var healthModel = HealthVM()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userModel)
                .environmentObject(healthModel)
                .environmentObject(imageUtil)
        }
    }
}
