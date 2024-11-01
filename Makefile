.PHONY: cli remove-cli

list:
	@echo "\n==========================="
	@echo "==    Swifty Scripty    =="
	@echo "==========================="
	@echo "==     Commands list     =="
	@echo "==========================="
	@echo "cli"
	@echo "remove-cli"

cli:
	@swift build --configuration release
	@sudo cp -f .build/release/SwiftyScriptyCLI /usr/local/bin/swiftyscripty

remove-cli:
	@sudo rm /usr/local/bin/swiftyscripty
