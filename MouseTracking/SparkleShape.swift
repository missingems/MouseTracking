import SwiftUI

struct SparkleShape: Shape {
  func path(in rect: CGRect) -> Path {
    let center = CGPoint(x: rect.midX, y: rect.midY)
    let outerRadius = min(rect.width, rect.height) / 2
    let innerRadius = outerRadius * 0.3
    
    var path = Path()
    let points = 8
    let angle = 2 * Double.pi / Double(points)
    let startAngle = -Double.pi / 2
    
    for i in 0..<points {
      let radius = (i % 2 == 0) ? outerRadius : innerRadius
      let theta = startAngle + Double(i) * angle
      let pt = CGPoint(
        x: center.x + CGFloat(cos(theta)) * radius,
        y: center.y + CGFloat(sin(theta)) * radius
      )
      if i == 0 {
        path.move(to: pt)
      } else {
        path.addLine(to: pt)
      }
    }
    
    path.closeSubpath()
    return path
  }
}
