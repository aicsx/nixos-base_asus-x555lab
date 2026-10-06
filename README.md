# ax's NixOS & Home Manager Dotfiles (xlab-555)

Welcome to my personal NixOS configuration repository, tailored specifically for the **Asus X555LAB** laptop. This setup utilizes **Nix Flakes** and **Home Manager** to deliver a fully declarative, reproducible, and robust operating system environment.

All configuration files and setup structures have been created and are maintained by **ax** (ax@slackware.eu).

---

## 💻 Hardware Specifications Target

This configuration is optimized and built for the following hardware:
* **Device:** Asus X555LAB
* **CPU:** Intel(R) Core(TM) i3-5005U (4) @ 1.90 GHz
* **Architecture:** x86_64

---

## 🎨 Base Environment & Software Stack

The system is configured around a lightweight, keyboard-driven workflow with the following core environment:

* **Window Manager:** `qtile` (dynamic tiling window manager)
* **Terminal Emulator:** `alacritty` (GPU-accelerated terminal)
* **Text Editor:** `nvim` (Neovim)
* **Application Launcher:** `rofi` (window switcher and launcher)
* **Compositor:** `picom` (X11 compositor for blurs and shadows)

### Additional Included Software:
* **Development & Tooling:** `gcc` (GNU Compiler Collection), `nodejs`, `nil` (Nix Language Server), `nixpkgs-fmt` (Nix code formatter).
* **Utilities & Theming:** `ripgrep` (fast line-oriented search), `imv` (image viewer for X11/Wayland), `papirus-icon-theme` (clean, pixel-perfect icon set).

---

## 📁 Repository Structure & Files

The repository consists of the following core configuration files:

| File Name | Description |
| :--- | :--- |
| `flake.nix` | The main entry point for the system deployment. It defines input dependencies (such as Nixpkgs channels and Home Manager) and outputs the system configuration. |
| `flake.lock` | Automatically generated lockfile ensuring exact cryptographic version tracking of all inputs for complete reproducibility. |
| `configuration.nix` | Core system-level configuration containing bootloaders, networking options, system packages, user accounts, and system-wide services (such as X11 and Qtile). |
| `hardware-configuration.nix` | Automatically generated hardware abstraction layer containing file system mounts, kernel modules, and CPU specific optimizations for the Asus X555LAB. |
| `home.nix` | Personal user-space environment config driven by Home Manager. It manages dotfiles, user packages (Alacritty, Neovim configs, etc.), shell aliases, and application-specific settings. |
| `LICENSE` | Repository licensing details (MIT License). |

---

## 🚀 Installation & Deployment

> ⚠️ **Warning:** Running these commands will modify your system configuration. Ensure you have backed up any critical data before proceeding.

### Prerequisite
Ensure you have NixOS installed with Flakes enabled. If Flakes are not yet enabled globally, append `--experimental-features "nix-command flakes"` to your commands.

### 1. Clone the Repository
```bash
git clone https://github.com/aicsx/nixos-dotfiles.git
cd nixos-dotfiles
```

### 2. Apply System Configuration
To build and switch to this system configuration, execute:
```bash
sudo nixos-rebuild switch --flake .#default
```
*(Replace `#default` with your specific hostname if custom-defined inside `flake.nix`)*

### 3. Apply Home Manager Configuration
To deploy user-space configurations and dotfiles:
```bash
home-manager switch --flake .#ax
```

---

## 🛠️ Routine Maintenance

### Update System Packages
To update all repository dependencies and system inputs to their latest matching revisions:
```bash
nix flake update
sudo nixos-rebuild switch --flake .#default
```

### Optimize & Garbage Collection
To clean up old system generations and free up disk space on the Asus X555LAB hardware:
```bash
sudo nix-env --delete-generations old
sudo nix-store --gc
```

---

## 🪪 License

This project is licensed under the **MIT License** - see the `LICENSE` file for details. Copyright (c) 2026 ax.

---

## 💬 Contact & Community

Feel free to reach out, ask questions, or discuss developments:
* **Author:** ax
* **Email:** [ax@slackware.eu](mailto:ax@slackware.eu)
* **IRC Network:** `irc1.slackware.eu` (UmbrellaNet)
* **IRC Channel:** `#lug`
