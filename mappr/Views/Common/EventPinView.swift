import SwiftUI

struct EventPinView: View {
    var color: Color = .blue
    var baseSize: CGFloat = 28
    var rsvpCount: Int = 0
    var title: String? = nil

    // RSVP-based scaling
    private var scaledSize: CGFloat {
        let minSize: CGFloat = baseSize
        let maxSize: CGFloat = baseSize * 2.0
        let normalized = min(1.0, CGFloat(rsvpCount) / 200.0)
        return minSize + (maxSize - minSize) * normalized
    }

    var body: some View {
        VStack(spacing: 4) {
            // Pin (teardrop style)
            ZStack {
                // Base pin shape
                PinShape()
                    .fill(color.gradient)
                    .frame(width: scaledSize, height: scaledSize * 1.4)
                    .shadow(color: color.opacity(0.4), radius: 3, y: 3)

                // Inner white highlight
                Circle()
                    .fill(Color.white.opacity(0.8))
                    .frame(width: scaledSize * 0.4, height: scaledSize * 0.4)
                    .offset(y: -scaledSize * 0.15)
            }

            // Event title under pin
            if let title = title {
                Text(title)
                    .font(.caption2)
                    .foregroundColor(.black.opacity(0.8))
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                    .frame(maxWidth: scaledSize * 2)
            }
        }
    }
}

// MARK: - Custom Teardrop Shape
struct PinShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let circleRadius = rect.width / 2
        let circleCenter = CGPoint(x: rect.midX, y: rect.midY * 0.7)

        // Circle part
        path.addArc(center: circleCenter,
                    radius: circleRadius,
                    startAngle: .degrees(0),
                    endAngle: .degrees(360),
                    clockwise: false)

        // Tail (bottom triangle)
        path.move(to: CGPoint(x: rect.midX - rect.width * 0.2, y: rect.maxY - rect.height * 0.3))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX + rect.width * 0.2, y: rect.maxY - rect.height * 0.3))
        path.closeSubpath()

        return path
    }
}


