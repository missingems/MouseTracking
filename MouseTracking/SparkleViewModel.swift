import SwiftUI

@Observable final class SparkleViewModel {
  static let shared = SparkleViewModel()
  
  enum AnimationState {
    case inactive, listening, processing
  }
  
  var currentState: AnimationState = .inactive
}
