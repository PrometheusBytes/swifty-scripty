import SwiftUI

struct PickerButtonStyle: ButtonStyle {
    @State var backgroundOpacity: Double = 0
    @State var foregroundColor = Color.white
    @State var xOffset: CGFloat = .zero
    @State var scaling: CGFloat = 1

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(foregroundColor)
            .frame(width: 250, alignment: .leading)
            .padding()
            .offset(x: xOffset)
            .scaleEffect(scaling, anchor: .leading)
            .onHover(perform: { hovering in
                withAnimation(.easeInOut) {
                    backgroundOpacity = hovering ? 1 : 0
                    foregroundColor = hovering ? .black : .white
                    xOffset = hovering ? 5 : .zero
                    scaling = hovering ? 1.2 : 1
                }
            })
            .background(RoundedRectangle(cornerRadius: 15).opacity(backgroundOpacity))
            .opacity(configuration.isPressed ? 0.5 : 1)
            .animation(.default, value: configuration.isPressed)
    }
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
