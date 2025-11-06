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
            OPENTOFU_VERSION="1.10.6"

            echo "Checking for required tool versions..."

            # Check if OpenTofu is installed at the correct version
            if ! tenv tf list | grep -q "$OPENTOFU_VERSION"; then
              echo "OpenTofu $OPENTOFU_VERSION is not installed."
              echo "Run: tenv tofu install $OPENTOFU_VERSION"
              INSTALL_NEEDED=1
            fi

            # If installations are needed, exit with instructions
            if [ -n "$INSTALL_NEEDED" ]; then
              echo ""
              echo "After installing the required versions, activate them with:"
              echo "tenv tofu use $OPENTOFU_VERSION"
              echo ""
              echo "Or run this shell again to verify."
            else
              # Set the versions to use
              tenv tf use $OPENTOFU_VERSION
              echo "Environment ready with OpenTofu $OPENTOFU_VERSION"
            fi
          '';
        };
      }
    );
}
