import AppKit

final class MouseTrackingManager {
  static let shared = MouseTrackingManager()
  
  private var globalEventMonitor: Any?
  private var localEventMonitor: Any?
  private var subscribers: [(NSEvent) -> Void] = []
  
  private init() {
    let eventMask: NSEvent.EventTypeMask = [
      .mouseMoved,
      .leftMouseDragged,
      .rightMouseDragged,
      .otherMouseDragged
    ]
    
    globalEventMonitor = NSEvent.addGlobalMonitorForEvents(matching: eventMask) { [weak self] event in
      self?.notifySubscribers(with: event)
    }
    
    localEventMonitor = NSEvent.addLocalMonitorForEvents(matching: eventMask) { [weak self] event in
      self?.notifySubscribers(with: event)
      return event
    }
  }
  
  func subscribe(_ handler: @escaping (NSEvent) -> Void) {
    subscribers.append(handler)
  }
  
  func unsubscribe(_ handler: @escaping (NSEvent) -> Void) {
    subscribers.removeAll { $0 as AnyObject === handler as AnyObject }
  }
  
  private func notifySubscribers(with event: NSEvent) {
    for subscriber in subscribers {
      subscriber(event)
    }
  }
}
