import SwiftUI

public protocol PickerDelegate {
    func didTap(option: SinglePickerOption)
}

public struct SinglePickerOption: Hashable, Identifiable {
    public let id: Int
    public let value: String

    public init(id: Int, value: String) {
        self.id = id
        self.value = value
    }
}

public struct SinglePicker: View {
    let title: String
    let options: [SinglePickerOption]
    let delegate: PickerDelegate

    let backgroundColor = Color(hex: 0x2d2d2d)
    let backgroundSecondary: Color = Color(hex: 0x424242)

    public init(
        title: String,
        options: [SinglePickerOption],
        delegate: PickerDelegate
    ) {
        self.title = title
        self.options = options
        self.delegate = delegate
    }

    public var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.largeTitle)
                .padding(.vertical)

                VStack(spacing: 10) {
                    ForEach(options) { option in
                        Button(action: {
                            delegate.didTap(option: option)
                        }) {
                            Text(option.value)
                                .font(.title2.weight(.thin))
                        }
                        .buttonStyle(PickerButtonStyle())
                    }
                }
                .padding(5)
                .background(backgroundSecondary)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.bottom)
            }
            .padding()
            .background(background)
        }
        .padding(.vertical)
        .background(Color.clear)
    }

    var background: some View {
        Rectangle()
            .fill(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    SinglePicker(
        title: "Pick an option",
        options: [
            .init(id: 1, value: "one"),
            .init(id: 2, value: "two"),
            .init(id: 3, value: "three"),
            .init(id: 4, value: "four"),
            .init(id: 5, value: "five"),
            .init(id: 6, value: "six"),
        ],
        delegate: PickerDelegateMock()
    )
}

class PickerDelegateMock: PickerDelegate {
    func didTap(option: SinglePickerOption) {}
}
