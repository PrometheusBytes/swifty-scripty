.PHONY: tests setup mocks clean list build_clean_script

list:
	@echo "\n==========================="
	@echo "==    Swifty Scripty    =="
	@echo "==========================="
	@echo "==     Commands list     =="
	@echo "==========================="
	@echo "build_scripts"

build_scripts:
	@swift package clean
	@swiftyscripty -s
	@swift build --configuration release
	@cp -f .build/release/SwiftyScriptyCLI ./SwiftyScriptyCLI
