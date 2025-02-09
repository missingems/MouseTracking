import AppKit
import SwiftUI

final class OverlayWindow: NSWindow {
  init() {
    let overlaySize = NSSize(width: 18, height: 18)
    let initialFrame = NSRect(origin: .zero, size: overlaySize)
    
    super.init(
      contentRect: initialFrame,
      styleMask: .borderless,
      backing: .buffered,
      defer: false
    )
    
    self.contentView = NSHostingController(rootView: SparkleGroup()).view
    self.level = .screenSaver
    self.backgroundColor = .clear
    self.isOpaque = false
    self.ignoresMouseEvents = true
    self.collectionBehavior = [.canJoinAllSpaces, .ignoresCycle]
    
    SparkleViewModel.shared.currentStateChanged = { [weak self] state in
      MouseTrackingManager.shared.unsubscribe()
      
      switch state {
      case .inactive:
        self?.contentView?.isHidden = true
        
      case .listening, .processing:
        self?.contentView?.isHidden = false
        self?.updateOverlayPosition()
        
        MouseTrackingManager.shared.subscribe { [weak self] event in
          self?.updateOverlayPosition()
        }
      }
    }
  }
  
  func updateOverlayPosition() {
    if isVisible == false {
      orderFrontRegardless()
    }
    let mouseLocation = NSEvent.mouseLocation
    let newOrigin = NSPoint(x: mouseLocation.x + 10, y: mouseLocation.y - 35)
    
    setFrameOrigin(newOrigin)
  }
}
