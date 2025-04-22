{
  description = "OpenTofu/Terragrunt Infrastructure development environment";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.systems.url = "github:nix-systems/default";
  inputs.flake-utils = {
    url = "github:numtide/flake-utils";
    inputs.systems.follows = "systems";
  };

  outputs =
    { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          packages = [
            pkgs.tenv
            pkgs.talosctl
            pkgs.pre-commit
            pkgs.terraform-docs
            pkgs.trivy
            pkgs.gitleaks
          ];

          # Define the versions we want to use
          shellHook = ''
            TERRAGRUNT_VERSION="0.77.22"
            OPENTOFU_VERSION="1.9.0"

            echo "Checking for required tool versions..."

            # Check if Terragrunt is installed at the correct version
            if ! tenv tg list | grep -q "$TERRAGRUNT_VERSION"; then
              echo "Terragrunt $TERRAGRUNT_VERSION is not installed."
              echo "Run: tenv tg install $TERRAGRUNT_VERSION"
              INSTALL_NEEDED=1
            fi

            # Check if OpenTofu is installed at the correct version
            if ! tenv tf list | grep -q "$OPENTOFU_VERSION"; then
              echo "OpenTofu $OPENTOFU_VERSION is not installed."
              echo "Run: tenv tf install $OPENTOFU_VERSION"
              INSTALL_NEEDED=1
            fi

            # If installations are needed, exit with instructions
            if [ -n "$INSTALL_NEEDED" ]; then
              echo ""
              echo "After installing the required versions, activate them with:"
              echo "tenv tg use $TERRAGRUNT_VERSION"
              echo "tenv tf use $OPENTOFU_VERSION"
              echo ""
              echo "Or run this shell again to verify."
            else
              # Set the versions to use
              tenv tg use $TERRAGRUNT_VERSION
              tenv tf use $OPENTOFU_VERSION
              echo "Environment ready with Terragrunt $TERRAGRUNT_VERSION and OpenTofu $OPENTOFU_VERSION"
            fi
          '';
        };
      }
    );
}
