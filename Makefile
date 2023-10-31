SOURCERY_PATH := ./Resources/ExternalLibraries/Sourcery-2.0.2/bin/sourcery
SWIFTGEN_PATH := ./Resources/ExternalLibraries/swiftgen-6.6.2/bin/swiftgen
.PHONY: tests setup mocks clean list build_clean_script

list:
	@echo "\n==========================="
	@echo "==    Swifty Scripty    =="
	@echo "==========================="
	@echo "==     Commands list     =="
	@echo "==========================="
	@echo "di_keys_and_mocks"
	@echo "tests"

di_keys_and_mocks:
	@echo "Removing Generated Code..."
	@rm -rf ./Sources/SwiftyScripty/Generated
	@echo "Generating Injection keys..."
	@$(SOURCERY_PATH) --config ./Resources/GenerationConfiguration/injectionKeys.yml
	@echo "Generating mocks..."
	@$(SOURCERY_PATH)  --config ./Resources/GenerationConfiguration/mocks.yml

tests:
	@make di_keys_and_mocks
	@echo "Starting tests..."
	@swift test

build_scripts:
	@make di_keys_and_mocks
	@swift package clean
	@swift build --configuration release
	@cp -f .build/release/CleanScript ./bin
	@cp -f .build/release/MakeSwiftScript ./bin
	@cp -f .build/release/SetupScript ./bin
