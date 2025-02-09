import SwiftUI

@Observable final class SparkleViewModel {
  static let shared = SparkleViewModel()
  
  enum AnimationState {
    case inactive, listening, processing
  }
  
  var currentStateChanged: ((AnimationState) -> Void)?
  
  var currentState: AnimationState = .inactive {
    didSet {
      currentStateChanged?(currentState)
    }
  }
}
