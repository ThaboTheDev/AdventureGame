# Contributing Guidelines

Thank you for considering contributing to this project! 🎉  
To keep the project clean, consistent, and easy to scale, please follow these guidelines.

---

## 📌 Commit Message Convention

We follow the **Conventional Commits** standard. This helps with readability, automation (changelog generation), and CI pipelines.

### Format


### Types

| Type      | Description                                                   |
|-----------|---------------------------------------------------------------|
| `feat`    | A new feature                                                 |
| `fix`     | A bug fix                                                     |
| `docs`    | Documentation changes (README, inline docs)                   |
| `style`   | Code style changes (formatting, spacing, linting, etc)        |
| `refactor`| Code change that doesn't fix a bug or add a feature           |
| `perf`    | Performance improvement                                       |
| `test`    | Adding or updating tests                                      |
| `chore`   | Routine tasks, build scripts, dependencies, configs           |
| `ci`      | CI/CD pipeline changes                                        |
| `build`   | Changes to the build system or external dependencies          |
| `revert`  | Revert a previous commit                                      |

### Scopes (Optional)

Use a scope to indicate what area is being affected:
- `auth`, `api`, `ui`, `login`, `docs`, `config`, etc.

### Examples

```bash

feat(auth): add login with Google

fix(api): handle 500 error from server gracefully

docs(readme): update install instructions

style(ui): apply consistent padding and font size

refactor(login): simplify validation logic

chore: upgrade dependencies to latest version
