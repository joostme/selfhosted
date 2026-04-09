# Selfhosted

Declarative self-hosted infrastructure managed with [Conflux](https://github.com/joostme/conflux).

## Prerequisites

- [Conflux](https://github.com/joostme/conflux)
- [SOPS](https://github.com/getsops/sops) + [Age](https://github.com/FiloSottile/age) (for secrets management)

## Project Structure

```
.
├── conflux.yaml           # Conflux manifest (source of truth)
├── renovate.json          # Renovate config for automated dependency updates
├── secrets.env            # Global secrets
└── stacks/
    ├── adguard/
    │   └── compose.yaml
    ├── arr/
    │   └── compose.yaml
    ├── traefik/
    │   └── compose.yaml
    └── .../
```
