# Selfhosted

Declarative self-hosted infrastructure managed with [Dockform](https://github.com/gcstr/dockform) v0.8.0-rc.

## Prerequisites

- [Dockform](https://github.com/gcstr/dockform) v0.8.0-rc
- Docker with a configured context named `nas`
- [SOPS](https://github.com/getsops/sops) + [Age](https://github.com/FiloSottile/age) (for secrets management)

## Project Structure

```
.
├── dockform.yaml          # Dockform manifest (source of truth)
├── renovate.json          # Renovate config for automated dependency updates
└── default/               # Context: default (Docker host)
    ├── secrets.env        # Global secrets (shared across stacks, SOPS-encrypted)
    ├── adguard/
    │   ├── compose.yaml
    │   ├── environment.env
    │   └── secrets.env
    ├── arr/
    │   ├── compose.yaml
    │   └── environment.env
    ├── traefik/
    │   ├── compose.yaml
    │   ├── environment.env
    │   └── secrets.env
    └── .../               # Other stacks follow the same pattern
```
