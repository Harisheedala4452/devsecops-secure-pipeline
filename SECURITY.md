# Security Policy

## Supported Scope

This is a portfolio and learning project. Security checks focus on:

- Python application code
- Python dependencies
- Docker image vulnerabilities
- Secret detection
- Terraform formatting and validation

## Reporting a Security Issue

Do not open a public issue with sensitive details. For a real production project, report privately through the organization's security contact.

For this learning project, create a private note with:

- What you found
- Which file or workflow is affected
- How to reproduce it
- Suggested remediation

## Common Security Issues Explained

### Hardcoded secrets

Secrets include API keys, tokens, private keys, database passwords, and cloud credentials. This project uses `.env.example` only and ignores real `.env` files.

### Vulnerable dependencies

Python packages can contain known CVEs. `pip-audit` checks dependencies and reports vulnerable versions.

### Insecure Python patterns

Bandit checks for risky Python code such as `eval`, unsafe subprocess usage, weak cryptography, and insecure temporary files.

### Vulnerable container images

Docker images include operating system packages and runtime dependencies. Trivy scans the image and reports high or critical vulnerabilities.

### Terraform mistakes

Terraform can accidentally expose infrastructure. This project validates syntax and formatting, but real deployments should also include policy checks, least-privilege IAM, remote state, and restricted network access.

## Secret Handling Rules

- Never commit real credentials.
- Keep local credentials in `.env`.
- Rotate any credential that is accidentally committed.
- Use GitHub Actions secrets for CI/CD credentials.
- Use cloud-native secret managers for production systems.
