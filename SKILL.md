---
name: nodejs-repo-template
description: "Scaffold a production-ready Node.js GitHub repository from scratch with ESLint, Prettier, Mocha/Chai tests, Husky pre-commit hooks, lint-staged, EditorConfig, CI/CD GitHub Actions (test + release), MIT license, Dependabot, PR template, and a clean src/tests folder structure. Triggers: 'new node project', 'scaffold nodejs', 'create repo template', 'init node repo', 'nodejs template', 'new npm package', 'github repo template', 'project scaffold'."
argument-hint: "Provide the project name (kebab-case), a one-line description, and the GitHub owner/org. Optionally specify: TypeScript (default: no), test framework (default: mocha+chai), min Node version (default: 18)."
---

# Node.js Repository Template — Scaffolding Skill

## Purpose

When invoked, scaffold a **complete, ready-to-push** Node.js repository. Every file below must be created verbatim (substituting only the placeholders). Do NOT skip files or "leave as exercise."

---

## Placeholders

| Token | Source | Example |
|---|---|---|
| `{{PROJECT_NAME}}` | User input (kebab-case) | `my-awesome-lib` |
| `{{DESCRIPTION}}` | User input | `A fast utility library` |
| `{{GITHUB_OWNER}}` | User input | `vladislavs` |
| `{{YEAR}}` | Current year | `2025` |
| `{{AUTHOR_NAME}}` | Ask or default to GitHub owner | `Vladislavs` |
| `{{NODE_MIN}}` | User input or `18` | `18` |

If the user doesn't supply a value, **ask** for `PROJECT_NAME` and `DESCRIPTION` at minimum. Default the rest.

---

## Target Folder Structure

```
{{PROJECT_NAME}}/
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
│       └── .gitkeep
├── tests/
│   ├── setup.js
│   └── index.test.js
├── .c8rc.json
├── .editorconfig
├── .eslintrc.json
├── .gitignore
├── .lintstagedrc.json
├── .nvmrc
├── .prettierignore
├── .prettierrc
├── CHANGELOG.md
├── LICENSE
├── README.md
└── package.json
```

After creating files, run:
```bash
cd {{PROJECT_NAME}}
git init
npm install
npx husky init
```
Then write the pre-commit hook file.

---

## File Contents

### `package.json`

```json
{
  "name": "{{PROJECT_NAME}}",
  "version": "0.0.0",
  "description": "{{DESCRIPTION}}",
  "main": "src/index.js",
  "files": [
    "src"
  ],
  "scripts": {
    "lint": "eslint .",
    "lint:fix": "eslint . --fix",
    "format": "prettier --write .",
    "format:check": "prettier --check .",
    "test": "mocha 'tests/**/*.test.js' --timeout 5000",
    "test:watch": "mocha 'tests/**/*.test.js' --watch",
    "test:coverage": "c8 mocha 'tests/**/*.test.js'",
    "validate": "npm run lint && npm run format:check && npm test",
    "prepare": "husky"
  },
  "repository": {
    "type": "git",
    "url": "git+https://github.com/{{GITHUB_OWNER}}/{{PROJECT_NAME}}.git"
  },
  "keywords": [],
  "author": "{{AUTHOR_NAME}}",
  "license": "MIT",
  "bugs": {
    "url": "https://github.com/{{GITHUB_OWNER}}/{{PROJECT_NAME}}/issues"
  },
  "homepage": "https://github.com/{{GITHUB_OWNER}}/{{PROJECT_NAME}}#readme",
  "engines": {
    "node": ">={{NODE_MIN}}"
  },
  "devDependencies": {
    "c8": "^10.1.0",
    "chai": "^4.5.0",
    "eslint": "^8.57.0",
    "eslint-config-prettier": "^9.1.0",
    "eslint-plugin-n": "^17.15.0",
    "eslint-plugin-promise": "^7.2.0",
    "husky": "^9.1.0",
    "lint-staged": "^15.4.0",
    "mocha": "^10.8.0",
    "prettier": "^3.4.0"
  }
}
```

> **Note**: Pin major versions only. `npm install` resolves latest compatible.

---

### `.eslintrc.json`

```json
{
  "env": {
    "node": true,
    "es2022": true,
    "mocha": true
  },
  "parserOptions": {
    "ecmaVersion": 2022,
    "sourceType": "module"
  },
  "extends": [
    "eslint:recommended",
    "plugin:n/recommended",
    "plugin:promise/recommended",
    "prettier"
  ],
  "rules": {
    "no-unused-vars": ["error", { "argsIgnorePattern": "^_" }],
    "no-console": "warn",
    "prefer-const": "error",
    "no-var": "error",
    "eqeqeq": ["error", "always"],
    "curly": ["error", "multi-line"],
    "no-throw-literal": "error",
    "prefer-template": "warn",
    "no-param-reassign": "warn",
    "n/no-process-exit": "warn",
    "n/no-unpublished-require": "off",
    "promise/always-return": "off"
  }
}
```

---

### `.prettierrc`

```json
{
  "singleQuote": true,
  "trailingComma": "all",
  "printWidth": 80,
  "tabWidth": 2,
  "semi": true,
  "arrowParens": "avoid",
  "endOfLine": "lf"
}
```

---

### `.prettierignore`

```
node_modules
coverage
dist
build
*.min.js
CHANGELOG.md
```

---

### `.editorconfig`

```ini
root = true

[*]
indent_style = space
indent_size = 2
end_of_line = lf
charset = utf-8
trim_trailing_whitespace = true
insert_final_newline = true

[*.md]
trim_trailing_whitespace = false

[Makefile]
indent_style = tab
```

---

### `.nvmrc`

```
{{NODE_MIN}}
```

---

### `.gitignore`

```gitignore
# Dependencies
node_modules/

# Build
dist/
build/

# Coverage
coverage/
.nyc_output/

# IDE
.idea/
.vscode/
*.swp
*.swo
*~

# OS
.DS_Store
Thumbs.db

# Environment
.env
.env.local
.env.*.local

# Logs
*.log
npm-debug.log*

# Package manager locks (keep only one)
yarn.lock
pnpm-lock.yaml
```

---

### `.lintstagedrc.json`

```json
{
  "*.js": ["eslint --fix", "prettier --write"],
  "*.{json,md,yml,yaml}": ["prettier --write"]
}
```

---

### `.husky/pre-commit`

> **IMPORTANT**: This file is created AFTER `npx husky init` runs. Overwrite the default with:

```sh
npx lint-staged
```

Make it executable: `chmod +x .husky/pre-commit`

---

### `.c8rc.json`

```json
{
  "all": true,
  "src": ["src"],
  "exclude": ["tests/**", "coverage/**"],
  "reporter": ["text", "lcov", "html"],
  "check-coverage": true,
  "branches": 80,
  "lines": 80,
  "functions": 80,
  "statements": 80
}
```

---

### `.github/workflows/lint.yml`

```yaml
name: Lint

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

permissions:
  contents: read

jobs:
  lint:
    name: ESLint & Prettier
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: 20
          cache: npm
      - run: npm ci
      - run: npm run lint
      - run: npm run format:check
```

---

### `.github/workflows/test.yml`

```yaml
name: Test

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

permissions:
  contents: read

jobs:
  test:
    name: Node ${{ matrix.node-version }} on ${{ matrix.os }}
    runs-on: ${{ matrix.os }}
    strategy:
      fail-fast: false
      matrix:
        node-version: [18, 20, 22]
        os: [ubuntu-latest]
        include:
          - node-version: 20
            os: macos-latest
          - node-version: 20
            os: windows-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node-version }}
          cache: npm
      - run: npm ci
      - run: npm test
      - name: Coverage
        if: matrix.node-version == 20 && matrix.os == 'ubuntu-latest'
        run: npm run test:coverage
      - name: Upload coverage to Codecov
        if: matrix.node-version == 20 && matrix.os == 'ubuntu-latest'
        uses: codecov/codecov-action@v4
        with:
          token: ${{ secrets.CODECOV_TOKEN }}
          directory: coverage
          fail_ci_if_error: false
```

---

### `.github/workflows/release.yml`

```yaml
name: Release

on:
  push:
    tags:
      - 'v*'

permissions:
  contents: write

jobs:
  release:
    name: Create GitHub Release
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - uses: actions/setup-node@v4
        with:
          node-version: 20
          cache: npm
          registry-url: https://registry.npmjs.org

      - run: npm ci
      - run: npm run validate

      - name: Generate release notes
        id: notes
        run: |
          PREV_TAG=$(git tag --sort=-v:refname | head -2 | tail -1)
          if [ -z "$PREV_TAG" ]; then
            NOTES=$(git log --pretty=format:"- %s (%h)" HEAD)
          else
            NOTES=$(git log --pretty=format:"- %s (%h)" "${PREV_TAG}..HEAD")
          fi
          {
            echo 'RELEASE_NOTES<<EOF'
            echo "$NOTES"
            echo 'EOF'
          } >> "$GITHUB_OUTPUT"

      - name: Create GitHub Release
        uses: softprops/action-gh-release@v2
        with:
          body: |
            ## What's Changed
            ${{ steps.notes.outputs.RELEASE_NOTES }}
          generate_release_notes: true

      # Uncomment to auto-publish to npm on release:
      # - name: Publish to npm
      #   run: npm publish --access public
      #   env:
      #     NODE_AUTH_TOKEN: ${{ secrets.NPM_TOKEN }}
```

---

### `.github/dependabot.yml`

```yaml
version: 2
updates:
  - package-ecosystem: npm
    directory: /
    schedule:
      interval: weekly
    open-pull-requests-limit: 10
    labels:
      - dependencies
    commit-message:
      prefix: "deps"

  - package-ecosystem: github-actions
    directory: /
    schedule:
      interval: weekly
    labels:
      - ci
    commit-message:
      prefix: "ci"
```

---

### `.github/PULL_REQUEST_TEMPLATE.md`

```markdown
## What

<!-- Brief description of the change -->

## Why

<!-- Motivation / context / link to issue -->

Closes #

## How

<!-- Implementation approach -->

## Checklist

- [ ] Tests added / updated
- [ ] Linting passes (`npm run lint`)
- [ ] Formatting passes (`npm run format:check`)
- [ ] No new warnings
```

---

### `LICENSE`

```
MIT License

Copyright (c) {{YEAR}} {{AUTHOR_NAME}}

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

### `README.md`

````markdown
# {{PROJECT_NAME}}

> {{DESCRIPTION}}

[![Lint](https://github.com/{{GITHUB_OWNER}}/{{PROJECT_NAME}}/actions/workflows/lint.yml/badge.svg)](https://github.com/{{GITHUB_OWNER}}/{{PROJECT_NAME}}/actions/workflows/lint.yml)
[![Test](https://github.com/{{GITHUB_OWNER}}/{{PROJECT_NAME}}/actions/workflows/test.yml/badge.svg)](https://github.com/{{GITHUB_OWNER}}/{{PROJECT_NAME}}/actions/workflows/test.yml)
[![codecov](https://codecov.io/gh/{{GITHUB_OWNER}}/{{PROJECT_NAME}}/graph/badge.svg)](https://codecov.io/gh/{{GITHUB_OWNER}}/{{PROJECT_NAME}})
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Node.js](https://img.shields.io/badge/node-%3E%3D{{NODE_MIN}}-brightgreen.svg)](https://nodejs.org)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://github.com/{{GITHUB_OWNER}}/{{PROJECT_NAME}}/pulls)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-fe5196.svg)](https://conventionalcommits.org)

## Installation

```bash
npm install {{PROJECT_NAME}}
```

## Usage

```js
const {{ PROJECT_NAME_CAMEL }} = require('{{PROJECT_NAME}}');
```

## Development

```bash
git clone https://github.com/{{GITHUB_OWNER}}/{{PROJECT_NAME}}.git
cd {{PROJECT_NAME}}
npm install
```

### Scripts

| Command | Description |
|---|---|
| `npm test` | Run tests |
| `npm run test:watch` | Run tests in watch mode |
| `npm run test:coverage` | Run tests with coverage |
| `npm run lint` | Lint source files |
| `npm run lint:fix` | Lint and auto-fix |
| `npm run format` | Format with Prettier |
| `npm run format:check` | Check formatting |
| `npm run validate` | Lint + format check + test |

### Releasing

1. Update `CHANGELOG.md`
2. Bump version: `npm version patch|minor|major`
3. Push with tags: `git push --follow-tags`
4. GitHub Actions creates the release automatically

## License

[MIT](LICENSE)
````

---

### `CHANGELOG.md`

```markdown
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/),
and this project adheres to [Semantic Versioning](https://semver.org/).

## [Unreleased]

### Added
- Initial project setup
```

---

### `src/index.js`

```js
'use strict';

/**
 * @param {string} name
 * @returns {string}
 */
function greet(name) {
  if (typeof name !== 'string' || !name.trim()) {
    throw new TypeError('name must be a non-empty string');
  }
  return `Hello, ${name}!`;
}

module.exports = { greet };
```

---

### `src/lib/.gitkeep`

Empty file — preserves the `lib/` directory in git.

---

### `tests/setup.js`

```js
'use strict';

const chai = require('chai');

global.expect = chai.expect;
```

> Also add to the **mocha section** of `package.json` (or create `.mocharc.yml`):

### `.mocharc.yml`

```yaml
require:
  - tests/setup.js
timeout: 5000
recursive: true
spec: 'tests/**/*.test.js'
```

---

### `tests/index.test.js`

```js
'use strict';

const { greet } = require('../src/index');

describe('greet()', function () {
  it('should return greeting for valid name', function () {
    expect(greet('World')).to.equal('Hello, World!');
  });

  it('should throw on empty string', function () {
    expect(() => greet('')).to.throw(TypeError);
  });

  it('should throw on non-string input', function () {
    expect(() => greet(42)).to.throw(TypeError);
  });
});
```

---

## Post-Scaffold Steps

Run these commands in order after all files are created:

```bash
cd {{PROJECT_NAME}}
git init
npm install
npx husky init
# Overwrite the default pre-commit hook:
echo 'npx lint-staged' > .husky/pre-commit
chmod +x .husky/pre-commit
# Verify everything works:
npm run validate
# Initial commit:
git add -A
git commit -m "feat: initial project scaffold"
```

Then to push to GitHub:
```bash
gh repo create {{GITHUB_OWNER}}/{{PROJECT_NAME}} --public --source . --push
```

---

## Customization Notes

- **TypeScript**: If user requests TS, add `typescript`, `@types/node`, `@types/mocha`, `@types/chai`, `ts-node` to devDeps. Change `src/` to `.ts` files. Add `tsconfig.json`. Update ESLint to use `@typescript-eslint/parser`.
- **Jest instead of Mocha**: Replace `mocha`+`chai`+`c8` with `jest`. Update test scripts and ESLint env.
- **Monorepo**: Add workspaces to `package.json`, restructure into `packages/`.
- **npm publish**: Uncomment the npm publish step in `release.yml` and set `NPM_TOKEN` secret.
