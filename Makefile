SOURCERY_PATH := ./Sources/SwiftyScripty/Resources/Binaries/sourcery
SWIFTGEN_PATH := ./Sources/SwiftyScripty/Resources/Binaries/swiftgen
RESOURCES_PATH := ./Sources/SwiftyScripty/Resources
.PHONY: tests setup mocks clean list build_clean_script

list:
	@echo "\n==========================="
	@echo "==    Swifty Scripty    =="
	@echo "==========================="
	@echo "==     Commands list     =="
	@echo "==========================="
	@echo "di_keys_and_mocks"
	@echo "tests"
	@echo "build_scripts"

di_keys_and_mocks:
	@echo "Removing Generated Code..."
	@rm -rf ./Sources/SwiftyScripty/Generated
	@echo "Generating Injection keys..."
	@$(SOURCERY_PATH) --config $(RESOURCES_PATH)/GenerationConfiguration/injectionKeys.yml
	@echo "Generating mocks..."
	@$(SOURCERY_PATH)  --config $(RESOURCES_PATH)/GenerationConfiguration/mocks.yml

tests:
	@make di_keys_and_mocks
	@echo "Starting tests..."
	@swift test

build_scripts:
	@make di_keys_and_mocks
	@swift package clean
	@swift build --configuration release
	@cp -f .build/release/MakeSwiftScript ./bin
	@cp -f .build/release/SetupScript ./bin
