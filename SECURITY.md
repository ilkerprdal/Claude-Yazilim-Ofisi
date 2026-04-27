# Security Policy

## Supported Versions

The latest minor release on `main` is supported. Older versions are not
patched — please update.

| Version | Supported |
|---------|-----------|
| 0.1.x   | ✅        |
| < 0.1   | ❌        |

## Reporting a Vulnerability

If you find a security issue **in this template** (the agent prompts,
installer, scripts), please:

1. **Do NOT open a public GitHub issue.**
2. Email: **ilker.pardal@gmail.com** with subject `[SOFTWARE-OFFICE-SECURITY]`
3. Include: description, reproduction steps, suggested fix (if any).

You'll get an acknowledgement within 7 days.

## Scope

**In scope** — issues in this template:
- Installer running unintended commands
- Agent prompts that leak secrets / bypass protections
- Permissions in `settings.json` that are too loose by default
- Supply-chain risks in scripts

**Out of scope** — these are upstream Claude / Anthropic concerns:
- Claude model output safety
- Claude Code (the CLI) itself
- Prompt injection inherent to LLMs

For Anthropic-side issues:
https://www.anthropic.com/responsible-disclosure-policy

## Defaults

The template ships with these protections in `.claude/settings.json`:

- ❌ Blocks `rm -rf:*`, `git push --force:*`
- ❌ Blocks reading `.env`, `.env.*`, `**/secrets/**`, `**/*.pem`, `**/*.key`
- ✅ Allows read-only Git, npm test, pytest by default

If you change these, document the rationale.

## Best Practices When Using

- Never paste API keys / secrets into Claude conversations
- Review every agent-proposed file change before approval
- Use `/security-review` before each release
- Keep `.env` out of version control (already in `.gitignore`)
