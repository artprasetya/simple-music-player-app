# Running app
run:
	@flutter run --target=lib/main.dart
	
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

