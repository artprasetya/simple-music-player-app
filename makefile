# Running flutter integration test to declared target
test:
ifdef target
	@flutter driver --target=test_driver/$(target) 
else
	@echo "Please declare the test target path without 'test_driver/'"
	@echo "Example: make testing target=login.dart"
endif

# Running flutter integration test to declared target, using integration_test package
itest:
ifdef target
	@flutter drive \
	--driver=test_driver/integration_test.dart \
	--target=integration_test/$(target)/$(target)_test.dart
else
	@echo "Please declare the test target/module without 'integration_test/'"
	@echo "Example: make testing target=login"
endif

# Rebase flutter from target branch
rebase:
	@git pull origin $(branch) --rebase

# Rebase flutter from target branch & push to current branch
pull:
	@git pull origin $(branch) --rebase

# Rebase flutter from target branch & push to current branch
push:
	@git pull origin $(branch) --rebase && git push

brunner:
	@flutter pub run build_runner build --delete-conflicting-outputs
