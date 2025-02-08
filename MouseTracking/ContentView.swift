import SwiftUI
import AppKit
import Combine

struct ListeningSparkleView: View {
  @State private var pulse = false
  var body: some View {
    SparkleShape()
      .fill(pulse ? Color(hex: 0x008080) : Color(hex: 0xB932F5))
      .scaleEffect(pulse ? 1.2 : 1.0)
      .onAppear {
        withAnimation(Animation.easeInOut(duration: 0.8)
          .repeatForever(autoreverses: true)) {
            pulse.toggle()
          }
      }
  }
}

struct ProcessingSparkleView: View {
  @State private var phase: CGFloat = 0
  
  let tealColor = Color(hex: 0xB932F5)
  let purpleColor = Color(hex: 0x797979)
  
  var body: some View {
    ZStack {
      SparkleShape()
        .stroke(
          style: StrokeStyle(lineWidth: 2, dash: [6, 12], dashPhase: phase)
        )
        .foregroundColor(tealColor)
      
      SparkleShape()
        .stroke(
          style: StrokeStyle(lineWidth: 2, dash: [6, 12], dashPhase: phase + 9)
        )
        .foregroundColor(purpleColor)
    }
    .onAppear {
      withAnimation(Animation.linear(duration: 4)
        .repeatForever(autoreverses: false)) {
          phase = -80
        }
    }
  }
}

struct OverlayView: View {
  let viewModel: SparkleViewModel
  
  var body: some View {
    Group {
      switch viewModel.currentState {
      case .inactive:
        EmptyView()
        
      case .listening:
        ListeningSparkleView()
        
      case .processing:
        ProcessingSparkleView()
      }
    }
    .frame(width: 18, height: 18)
  }
}

struct ContentView: View {
  let viewModel: SparkleViewModel
  
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
