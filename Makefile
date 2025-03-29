# The name of the nixosConfiguration in the flake
NIXNAME ?= vm-aarch64

# We need to do some OS switching below.
UNAME := $(shell uname)

default: switch

# Build and switch to the configuration
switch:
ifeq ($(UNAME), Darwin)
	echo "Macos build"
	nix build --extra-experimental-features nix-command --extra-experimental-features flakes ".#darwinConfigurations.ArchMac.system"
		./result/sw/bin/darwin-rebuild switch --flake "$$(pwd)#ArchMac"
else
	echo "NixOS build"
	sudo NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM=1 nixos-rebuild switch --flake ".#${NIXNAME}"
endif
