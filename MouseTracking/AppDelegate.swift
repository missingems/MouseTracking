import AppKit
import SwiftUI

final class AppDelegate: NSObject, NSApplicationDelegate {
  let viewModel = SparkleViewModel()
  var overlayWindow: NSWindow?
  var globalEventMonitor: Any?
  var localEventMonitor: Any?
  
  func applicationDidFinishLaunching(_ notification: Notification) {
    let overlayView = OverlayView(viewModel: viewModel)
    let hostingController = NSHostingController(rootView: overlayView)
    hostingController.view.wantsLayer = true
    
    let window = NSWindow(contentViewController: hostingController)
    window.styleMask = .borderless
    window.backgroundColor = .clear
    window.isOpaque = false
    window.level = .screenSaver
    window.ignoresMouseEvents = true
    window.collectionBehavior = [.canJoinAllSpaces, .ignoresCycle]
    
    let overlaySize = NSSize(width: 24, height: 24)
    window.setFrame(NSRect(origin: .zero, size: overlaySize), display: true)
    window.orderFrontRegardless()
    overlayWindow = window
    
    let eventMask: NSEvent.EventTypeMask = [
      .mouseMoved,
      .leftMouseDragged,
      .rightMouseDragged,
      .otherMouseDragged
    ]
    
    globalEventMonitor = NSEvent.addGlobalMonitorForEvents(matching: eventMask) { [weak self] event in
      self?.updateOverlayPosition(with: event)
    }
    
    localEventMonitor = NSEvent.addLocalMonitorForEvents(matching: eventMask) { [weak self] event in
      self?.updateOverlayPosition(with: event)
      return event
    }
  }
  
  func updateOverlayPosition(with event: NSEvent) {
    DispatchQueue.main.async { [weak self] in
      guard let self = self, let overlayWindow = self.overlayWindow else { return }
      
      if overlayWindow.isVisible == false {
        overlayWindow.orderFrontRegardless()
      }
      let mouseLocation = NSEvent.mouseLocation
      let newOrigin = NSPoint(x: mouseLocation.x + 10, y: mouseLocation.y - 35)
      
      overlayWindow.setFrameOrigin(newOrigin)
    }
  }
  
  func applicationWillTerminate(_ notification: Notification) {
    if let monitor = globalEventMonitor {
      NSEvent.removeMonitor(monitor)
    }
    
    if let monitor = localEventMonitor {
      NSEvent.removeMonitor(monitor)
    }
  }
}
