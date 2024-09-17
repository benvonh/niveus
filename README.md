# niveus

> niveus: a Nix flake for Home Manager

**Niveus** is the singular, nominative, masculine form of the word **snowy** in Latin.

This Nix flake configuration includes:
- Zsh
- Tmux
- Neovim

Install `nix` before continuing.

## Getting Started

Enter the custom shell for convenience (optional).
```sh
nix develop --extra-experimental-features 'nix-command flakes' github:benvonh/niveus
```

### Online Install

:warning: You will need to manually delete configurations made by the Nix flake.

```sh
home-manager switch --flake github:benvonh/niveus#ben
```

### Local Install

```sh
git clone https://github.com/benvonh/niveus ~/niveus
home-manager switch --flake ~/niveus
```
