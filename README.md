# swifty-scripty

SwiftyScripty is a Swift package that enables you to create new scripts using a CLI, and it interacts with various tools such as shell, Git commands, Sourcery, and more. By simply importing and injecting dependencies with Swift code, you can streamline your script creation process.

## Features

- CLI Tool: A CLI tool that generates new scripts with SwiftyScripty already imported.

- Dependency Injection: An injection mechanism to easily manage dependencies in your scripts.

- Integration with Tools: Seamless integration with shell commands, Git commands, Sourcery, and other utilities.

## Installation
To install SwiftyScripty, follow these steps:

1. Download the binary file provided here.

2. Place the binary in a directory included in your system's PATH.

3. Make the binary executable:

  ```
  chmod +x /path/to/swiftyscripty
  ```

## Usage

Once installed, you can use the CLI tool to generate and manage your scripts. Here are the available commands:

- Generate Script: Generates a script in a subfolder with the name provided inside the current folder.

```sh
swiftyscripty -g <script-name>
```

```sh
swiftyscripty --generate <script-name>
```

- Setup Script: Generates all the mocks and injection keys needed to make injection work. If you create a new protocol and implementation, mark the protocol with the tag //sourcery:AutoMockable and name the implementation as the protocol with Impl at the end (e.g., MyProtocol and MyProtocolImpl), then by running the setup, you will be able to inject your protocol in the script.

```sh
swiftyscripty -s
```

```sh
swiftyscripty --setup
```
- Build Script: Creates a binary of your script that can be run everywhere.
```sh
swiftyscripty -b
```

```sh
swiftyscripty --build
```

- Help: Displays help information.
```sh
swiftyscripty -h
```

```sh
swiftyscripty --help
```

## Example

To create a new script:

1. Run the generate command inside the folder you want your command in:

```sh
swiftyscripty -g MyNewScript
```
2. Navigate to the generated folder and start coding your script with SwiftyScripty already imported.

To set up dependency injection for your script:

1. Create your protocol and implementation:

```swift
// MyProtocol.swift
// sourcery:AutoMockable
protocol MyProtocol {
    func doSomething()
}

// MyProtocolImpl.swift
class MyProtocolImpl: MyProtocol {
    func doSomething() {
        print("Doing something!")
    }
}
```

2. Run the setup command from your terminal inside the script folder:

```sh
swiftyScript -s
```

3. Inject your new protocol inside your script

```swift
import Foundation
import SwiftyScripty

@main
public struct MyScript {
    @Injected(\.myProtocol) var myProtocol: MyProtocol

    public static func main() {
        MyScript().main(args: CommandLine.arguments)
    }

    public func main(args: [String] = []) {
        myProtocol.doSomething()
    }
}
```

## Contributing

We welcome contributions! Please read our contributing guidelines to get started.

## License

This project is licensed under the [MIT License](LICENSE).

## Contact

For support or questions, feel free to open an issue on GitHub or contact us at email@example.com.
