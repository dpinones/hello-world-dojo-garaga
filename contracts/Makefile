katana:
	katana --dev --dev.no-fee --http.cors_origins "*" 

setup:
	@./scripts/setup.sh

deploy-slot:
	@./scripts/deploy_slot.sh $(PROFILE) $(ACTION)

deploy-sepolia:
	@./scripts/deploy_sepolia.sh $(ACTION)

generate-event-keys:
	@./scripts/generateEventKeys.sh

# Define tasks that are not real files
.PHONY: deploy-slot deploy-sepolia katana setup torii generate-event-keys

# Catch-all rule for undefined commands
%:
	@echo "Error: Command '$(MAKECMDGOALS)' is not defined."
	@exit 1
