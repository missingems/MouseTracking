import AppKit
import SwiftUI

final class AppDelegate: NSObject, NSApplicationDelegate {
  var overlayWindow: NSWindow?
  
  func applicationDidFinishLaunching(_ notification: Notification) {
    overlayWindow = OverlayWindow()
  }
}
