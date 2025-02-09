import SwiftUI
import AppKit
import Combine

struct ContentView: View {
  let viewModel = SparkleViewModel.shared
  
  var body: some View {
    HStack {
      Button("Inactive") {
        viewModel.currentState = .inactive
      }
      
      Button("Listening") {
        viewModel.currentState = .listening
      }
      
      Button("Processing") {
        viewModel.currentState = .processing
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}
