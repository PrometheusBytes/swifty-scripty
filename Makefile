.PHONY: cli remove-cli build build-app

list:
	@echo "\n==========================="
	@echo "==    Swifty Scripty    =="
	@echo "==========================="
	@echo "==     Commands list     =="
	@echo "==========================="
	@echo "cli"
	@echo "remove-cli"
	@echo "build-app"

build:
	@swift build --configuration release

build-app:
	@make build
	@mv .build/release/SwiftyScriptyApp Sources/SwiftyScripty/Resources/Binaries/SwiftyScriptyApp

cli:
	@make build
	@sudo cp -f .build/release/SwiftyScriptyCLI /usr/local/bin/swiftyscripty

remove-cli:
	@sudo rm /usr/local/bin/swiftyscripty
