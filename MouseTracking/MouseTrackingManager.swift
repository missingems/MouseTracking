import AppKit

final class MouseTrackingManager {
  static let shared = MouseTrackingManager()
  
  private var globalEventMonitor: Any?
  private var localEventMonitor: Any?
  private var subscribers: [(NSEvent) -> Void] = []
  
  func subscribe(_ handler: @escaping (NSEvent) -> Void) {
    subscribers.append(handler)
    let eventMask: NSEvent.EventTypeMask = [
      .mouseMoved,
      .leftMouseDragged,
      .rightMouseDragged,
      .otherMouseDragged
    ]
    
    let globalEventMonitor = NSEvent.addGlobalMonitorForEvents(matching: eventMask) { [weak self] event in
      self?.notifySubscribers(with: event)
    }
    
    let localEventMonitor = NSEvent.addLocalMonitorForEvents(matching: eventMask) { [weak self] event in
      self?.notifySubscribers(with: event)
      return event
    }
    
    self.globalEventMonitor = globalEventMonitor
    self.localEventMonitor = localEventMonitor
  }
  
  func unsubscribe() {
    subscribers.removeAll()
    
    if let globalEventMonitor = globalEventMonitor, let localEventMonitor = localEventMonitor {
      NSEvent.removeMonitor(globalEventMonitor)
      NSEvent.removeMonitor(localEventMonitor)
      self.globalEventMonitor = nil
      self.localEventMonitor = nil
    }
  }
  
  private func notifySubscribers(with event: NSEvent) {
    for subscriber in subscribers {
      subscriber(event)
    }
  }
}
