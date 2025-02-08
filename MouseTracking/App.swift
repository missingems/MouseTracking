import SwiftUI

@main struct Main: App {
  @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  
  var body: some Scene {
    WindowGroup {
      ContentView(viewModel: appDelegate.viewModel)
    }
  }
}
