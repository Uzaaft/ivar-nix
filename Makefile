# Connectivity info for Linux VM
NIXADDR ?= unset
NIXPORT ?= 22
NIXUSER ?= ivare

# Get the path to this Makefile and directory
MAKEFILE_DIR := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

# SSH options that are used. These aren't meant to be overridden but are
# reused a lot so we just store them up here.
SSH_OPTIONS=-o PubkeyAuthentication=no -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no

# The name of the nixosConfiguration in the flake
NIXNAME ?= vm-aarch64

# We need to do some OS switching below.
UNAME := $(shell uname)

default: switch

# Build and switch to the configuration
switch:
ifeq ($(UNAME), Darwin)
	echo "Not supported"
else
	sudo NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM=1 nixos-rebuild switch --flake ".#${NIXNAME}"
endif

# run the nixos-rebuild switch command. This does NOT copy files so you
# have to run vm/copy before.
vm/switch:
	ssh$(SSH_OPTIONS) -p$(NIXPORT) $(NIXUSER)@$(NIXADDR) " \
		sudo NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM=1 nixos-rebuild switch --flake \"~/nix-config#${NIXNAME}\" \
	"

# Test the configuration without switching
test:
	darwin-rebuild test --flake .#

# Clean build artifacts
clean:
	nix-collect-garbage -d

# Update all flake inputs
update:
	nix flake update

# Show the current system generation
show:
	darwin-rebuild --list-generations

help:
	@echo "Available targets:"
	@echo "  build   - Build the configuration"
	@echo "  switch  - Build and switch to the configuration"
	@echo "  test    - Test the configuration without switching"
	@echo "  clean   - Clean build artifacts"
	@echo "  update  - Update all flake inputs"
	@echo "  show    - Show system generations"
