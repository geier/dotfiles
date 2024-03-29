#
# After editing, run `darwin-rebuild switch`
#
{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [
      pkgs.age
      pkgs.ansible
      pkgs.bat # cat with syntax highlighting
      pkgs.bats # bash automated testing system
      pkgs.cargo
      pkgs.coreutils
      pkgs.du-dust
      pkgs.duf
      pkgs.dyff  # diffing YAML and json
      pkgs.eza  # nicer ls alternative
      pkgs.fish
      pkgs.fzf
      pkgs.fzy
      pkgs.git
      pkgs.git-extras
      pkgs.git-filter-repo
      pkgs.go
      pkgs.haskellPackages.pandoc-sidenote
      pkgs.imagemagick  # needed for experiments with images in vim
      pkgs.istioctl
      pkgs.jq
      pkgs.k9s
      pkgs.kubectx
      pkgs.kubernetes-helm
      pkgs.kustomize
      pkgs.lua
      pkgs.minio-client
      pkgs.moreutils
      pkgs.neovim
      pkgs.nodePackages.npm
      pkgs.nodePackages.pyright
      pkgs.nodejs
      pkgs.pandoc
      pkgs.ripgrep
      pkgs.rsync   # rsync shipped with Mac OS is really old
      pkgs.ruff
      pkgs.sops
      pkgs.tig
      pkgs.tmux
      pkgs.tree
      pkgs.tree-sitter
      pkgs.vim
      pkgs.visidata
      pkgs.wget
      pkgs.yq-go
      pkgs.zk
      pkgs.zsh
      pkgs.zsh-completions
    ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
