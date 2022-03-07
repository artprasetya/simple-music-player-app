# Build mode
mode := debug

# Clean build apk
clean := false

# Running app
run:
	@flutter run --target=lib/main.dart

# Build android apk & open file location
apk:
ifeq ($(mode),release)
	@flutter clean && flutter packages get
	@flutter build apk --obfuscate --split-debug-info=build/app/outputs/symbols
	@cd build/app/outputs/apk/release && open .
else
	@flutter clean && flutter packages get
	@flutter build apk --debug
	@cd build/app/outputs/apk/debug && open .
endif
	
# Running flutter integration test 
itest:
	@flutter test integration_test/app_test.dart

# Rebase flutter from target branch
rebase:
	@git pull origin $(branch) --rebase

# Rebase flutter from target branch & push to current branch
pull:
	@git pull origin $(branch) --rebase

# Rebase flutter from target branch & push to current branch
push:
	@git pull origin $(branch) --rebase && git push

