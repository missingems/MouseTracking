import SwiftUI

@Observable final class SparkleViewModel {
  enum AnimationState {
    case inactive, listening, processing
  }
  
  var currentState: AnimationState = .inactive
}
