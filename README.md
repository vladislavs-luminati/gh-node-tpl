# gh-node-tpl

> A GitHub Copilot AI skill that scaffolds production-ready Node.js repositories with code quality tooling, CI/CD workflows, and best practices baked in.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## What You Get

Every scaffolded repo includes:

| Category | Tools |
|---|---|
| **Linting** | ESLint (recommended + node + promise + prettier) |
| **Formatting** | Prettier, EditorConfig |
| **Testing** | Mocha + Chai, c8 coverage with 80% thresholds |
| **Coverage** | Codecov integration with badge |
| **Pre-commit** | Husky + lint-staged (auto-fix JS, format JSON/MD/YAML) |
| **CI — Lint** | GitHub Actions: ESLint + Prettier check on push/PR |
| **CI — Test** | GitHub Actions: Node 18/20/22 matrix, ubuntu/macos/windows |
| **CI — Release** | Tag-triggered GitHub Release with auto-generated notes |
| **Extras** | Dependabot (npm + actions), PR template, `.nvmrc`, MIT license |

### Generated Folder Structure

```
my-project/
├── .github/
│   ├── workflows/
│   │   ├── lint.yml
│   │   ├── test.yml
│   │   └── release.yml
│   ├── PULL_REQUEST_TEMPLATE.md
│   └── dependabot.yml
├── src/
│   ├── index.js
│   └── lib/
├── tests/
│   ├── setup.js
│   └── index.test.js
├── .c8rc.json
├── .editorconfig
├── .eslintrc.json
├── .gitignore
├── .lintstagedrc.json
├── .mocharc.yml
├── .nvmrc
├── .prettierignore
├── .prettierrc
├── CHANGELOG.md
├── LICENSE
├── README.md
└── package.json
```

## Installation

### One-liner

```bash
curl --proto =https -fsSL https://raw.githubusercontent.com/vladislavs/gh-node-tpl/main/install.sh -o /tmp/gh-node-tpl-install.sh
cat /tmp/gh-node-tpl-install.sh   # inspect before running
bash /tmp/gh-node-tpl-install.sh && rm /tmp/gh-node-tpl-install.sh
```

### Quick Install

```bash
git clone https://github.com/vladislavs/gh-node-tpl.git
cd gh-node-tpl
./install.sh
```

This copies `SKILL.md` to `~/.copilot/skills/nodejs-repo-template/` and prints the registration snippet.

### Manual Install

```bash
mkdir -p ~/.copilot/skills/nodejs-repo-template
cp SKILL.md ~/.copilot/skills/nodejs-repo-template/SKILL.md
```

### Register the skill in your Copilot instructions

Add the following to your `.github/copilot-instructions.md` or VS Code settings (`settings.json` → `github.copilot.chat.codeGeneration.instructions`):

```xml
<skill>
  <name>nodejs-repo-template</name>
  <description>Scaffold a production-ready Node.js GitHub repository from scratch with ESLint, Prettier, Mocha/Chai tests, Husky pre-commit hooks, lint-staged, EditorConfig, CI/CD GitHub Actions (test + release), MIT license, Dependabot, PR template, and a clean src/tests folder structure. Triggers: 'new node project', 'scaffold nodejs', 'create repo template', 'init node repo', 'nodejs template', 'new npm package', 'github repo template', 'project scaffold'.</description>
  <file>~/.copilot/skills/nodejs-repo-template/SKILL.md</file>
</skill>
```

### Verify

Open GitHub Copilot Chat in VS Code and say:

> scaffold a new node project

Copilot should pick up the skill and ask you for the project name and description.

## Usage

### Basic

```
> create a new node repo called my-utils with description "Shared utility functions"
```

Copilot will scaffold all files, run `npm install`, set up Husky, and make the initial commit.

### With Options

```
> scaffold nodejs project my-api, description "REST API service", github owner myorg, node 20
```

### Supported Parameters

| Parameter | Required | Default |
|---|---|---|
| Project name (kebab-case) | **Yes** | — |
| Description | **Yes** | — |
| GitHub owner/org | No | Asks or uses git config |
| Author name | No | GitHub owner |
| Min Node version | No | `18` |

## What Happens After Scaffolding

The skill runs these post-scaffold steps automatically:

```bash
cd <project>
git init
npm install
npx husky init
echo 'npx lint-staged' > .husky/pre-commit
chmod +x .husky/pre-commit
npm run validate        # lint + format check + tests
git add -A
git commit -m "feat: initial project scaffold"
```

### Push to GitHub

```bash
gh repo create <owner>/<project> --public --source . --push
```

### Release Flow

```bash
npm version patch       # bumps version + creates git tag
git push --follow-tags  # triggers release workflow
```

## Customization

The skill supports these variations when requested:

- **TypeScript** — adds `typescript`, `@types/*`, `ts-node`, `tsconfig.json`, updates ESLint parser
- **Jest** — replaces Mocha+Chai+c8 with Jest, updates scripts and ESLint env
- **Monorepo** — adds npm workspaces, restructures into `packages/`
- **npm publish** — uncomments the publish step in `release.yml` (requires `NPM_TOKEN` secret)

## License

[MIT](LICENSE)
