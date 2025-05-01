# tf-live: Homelab Live Infrastructure Configuration (OpenTofu)

This repository contains the "live" OpenTofu configuration for managing my personal homelab infrastructure. It defines
the specific resources and environments, consuming reusable components from a separate modules repository.

**NOTE on Repository Mirroring:** My primary repository is hosted on a self-hosted Gitea instance (`git.imkumpy.in`).
This GitHub repository is a mirror for components I'm comfortable sharing publicly. You might encounter internal links
(e.g., `gitea.imkumpy.in`) that are not accessible externally.

## Overview

The goal of this repository is to declaratively manage my homelab infrastructure using OpenTofu. It serves as the
top-level configuration layer, defining *what* resources exist in *which* environment.

Key infrastructure components managed here include:

*   Proxmox Virtual Machines
*   Network Configurations (within Proxmox/relevant systems)
*   Kubernetes Cluster Setup (via VMs)
*   More TBD

This repository works closely with its sister repository containing reusable OpenTofu Modules: **[https://github.com/tcpkump/tf-modules]**. This `tf-live` repository consumes those modules to instantiate infrastructure for different
environments (e.g., `dev`, `prod`). This separation promotes:

*   **Reusability:** Common infrastructure patterns are defined once in modules.
*   **Consistency:** Environments are built using the same tested building blocks.
*   **Abstraction:** The "live" configuration focuses on high-level composition, hiding implementation details within
modules.

## Repository Structure

The repository is organized by provider/platform, then environment, then component:

```
.
├── flake.lock             # Nix flake lock file
├── flake.nix              # Nix flake definition (defines dev environment)
├── proxmox                # Infrastructure managed within Proxmox
│   ├── dev                # Development environment
│   │   ├── k8s            # Kubernetes cluster resources
│   │   │   ├── backend.tf # State backend config
│   │   │   ├── main.tf    # Resource definitions (uses modules)
│   │   │   ├── ...        # Other standard Terraform files
│   │   │   └── README.md  # Specific notes for this component
│   │   └── network        # Network resources for dev
│   │       └── ...
│   └── prod               # Production environment
│       └── network        # Network resources for prod
│           └── ...
└── README.md              # This file
```

Each lowest-level directory (like `proxmox/dev/k8s`) represents a distinct OpenTofu root module, managing a specific
piece of infrastructure with its own state.

## Prerequisites

Before you can use this configuration, you'll need:

*   [Nix](https://nixos.org/download.html) (with Flakes enabled)
*   [direnv](https://direnv.net/docs/installation.html)
*   Access credentials for services being managed (e.g., Proxmox API Token, Gitea credentials). These are provided via
environment variables (see Configuration below).

## Development Environment Setup

This repository uses [Nix Flakes](https://nixos.wiki/wiki/Flakes) to ensure a consistent and reproducible development
environment. Most necessary tooling (like specific providers or utility scripts) is defined in `flake.nix`.

**Note on OpenTofu Version Management:** While Nix manages most dependencies, OpenTofu itself is managed using
[**tenv**](https://github.com/tofuutils/tenv). This tool allows for flexible management of multiple OpenTofu versions
and typically installs them in the user's home directory. The Nix flake environment provided by this repository is
configured to **detect** if the required OpenTofu version (as managed by `tenv`) is available in your `PATH`. If the
correct version is not found, activating the Nix environment (`nix develop` or via `direnv`) should provide guidance or
instructions on how to install or switch to the required version using `tenv`. This approach was chosen to leverage
`tenv`'s specific version management capabilities.

[Direnv](https://direnv.net/) is used for convenience to automatically load the Nix environment and manage secrets via
environment variables when you `cd` into the repository directory.

**To set up the environment:**

1.  Ensure Nix (with Flakes enabled), direnv, and `tenv` are installed and operational.
2.  Clone this repository.
3.  Navigate into the repository's root directory.
4.  **(If needed)** Use `tenv` to install and select the OpenTofu version required by this project.
5.  Create a `.envrc` file (see Configuration section below).
6.  Run `direnv allow` to grant direnv permission to load the environment (it will also trigger `nix develop` and
    validate the OpenTofu version).

Your shell should now have access to the necessary tools and the correct OpenTofu version should be available via
`tenv`.

## Configuration and Secrets

Configuration, especially secrets like API tokens, is managed using environment variables prefixed with `TF_VAR_`. These
are loaded automatically by direnv via an `.envrc` file in the repository root.

**IMPORTANT:** The `.envrc` file should contain sensitive information and **must not** be committed to version control.
Ensure `.envrc` is listed in your `.gitignore` file.

Here is an example structure for your `.envrc`:

```bash
# .envrc - DO NOT COMMIT TO GIT

# Load parent direnv config if it exists
source_up_if_exists

# Activate the Nix development environment defined in flake.nix
use flake

# --- Secrets ---
# Proxmox Credentials
export TF_VAR_proxmox_api_token='REDACTED_YOUR_PROXMOX_TOKEN_ID=YOUR_USER@pve!YOUR_TOKEN_NAME=SECRET_VALUE'
# Note: Adjust the variable names below if needed based on your variables.tf files
# Gitea Credentials (if used by any module/resource)
export TF_VAR_gitea_username='REDACTED_YOUR_GITEA_USERNAME'
export TF_VAR_gitea_password='REDACTED_YOUR_GITEA_PASSWORD'

# Add any other required environment variables here
```

Fill in the REDACTED values with your actual credentials.

## Usage Workflow

1. Setup: Ensure your Development Environment is set up and your .envrc is created and populated.
2. Navigate: cd into the specific directory you want to manage (e.g., cd proxmox/dev/k8s).
3. Initialize: Run `tofu init` to initialize the backend and download providers.
4. Plan: Run `tofu plan` to see the proposed changes.
5. Apply: Run `tofu apply` to create or update the infrastructure.

Repeat steps 3-5 for each distinct infrastructure component/directory you wish to manage.

## State Management

OpenTofu state is managed independently for each component directory (e.g., `proxmox/dev/k8s`), ensuring separation
between different parts of the infrastructure. The specific backend configuration, which defines where the state file is
stored, is located in the `backend.tf` file within each respective directory.

This configuration uses an **S3 backend** to store the state files remotely. Authentication for accessing the S3 bucket
relies on standard AWS credentials being available in the environment where OpenTofu commands are executed (e.g., via
environment variables like `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `AWS_SESSION_TOKEN`, or through an assumed IAM
role). Ensure your environment is correctly configured with the necessary AWS credentials before running `tofu init` or
other state-modifying commands.

## Disclaimer

This configuration is highly specific to my personal homelab setup, hardware, and network topology. It is shared under
the terms of the **MIT License** (see the `LICENSE` file) primarily as an example and for inspiration.

Please be aware that **significant adaptation will likely be required** for use in any other environment. As stated in
the MIT License, the software is provided **"AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED**, and the author
is not liable for any claim, damages, or other liability arising from its use. No direct support is provided for this
configuration.
