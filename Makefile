katana:
	katana --dev --dev.no-fee --http.cors_origins "*" 

setup: 
	@./scripts/setup.sh

deploy-sepolia:
	@./scripts/deploy_sepolia.sh

deploy-is-wolf:
	./scripts/deploy_is_wolf.sh

deploy-kill-sheep:
	./scripts/deploy_kill_sheep.sh