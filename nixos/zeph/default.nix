{ inputs, outputs, lib, config, pkgs, ... }:
{
  imports = [ 
    ./hardware.nix
    inputs.hardware.nixosModules.asus-zephyrus-ga402
  ];

  boot = {
    plymouth.enable = true;
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      timeout = 5;
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
        configurationLimit = 3;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    libnotify
    vimix-cursors
    sddm-astronaut-theme
    vim git
  ];

  services.xserver = {
    enable = true;
    displayManager.sddm = {
      enable = true;
      theme = "astronaut";
      settings.Theme.CursorTheme = "dist-white";
    };
  };

  programs = {
    zsh.enable = true;
    steam.enable = true;
    hyprland.enable = true;
    nm-applet.enable = true;
  };

  users.users.ben = {
    shell = pkgs.zsh;
    isNormalUser = true;
    initialPassword = "bender";
    extraGroups = [
      "wheel"
      # "docker"
      "networkmanager"
    ];
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    (nerdfonts.override {
      fonts = [ "CascadiaCode" ];
    })
  ];

  # Fix Swaylock no password
  security.pam.services.swaylock = { };

  # virtualisation.docker.enable = true;

  networking.hostName = "zeph";

  system.stateVersion = "24.05";

  nixpkgs.config.allowUnfree = false;

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      auto-optimise-store = true;
      experimental-features = "nix-command flakes";
      flake-registry = ""; # disable global registry
      nix-path = config.nix.nixPath; # hot fix
    };
    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "-d --repair";
      randomizedDelaySec = "45min";
    };

    channel.enable = false;
    # match flake inputs for registry and nix path
    registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };
  # nix = {
  #   registry = (lib.mapAttrs (_: flake: { inherit flake; }))
  #   ((lib.filterAttrs (_: lib.isType "flake")) inputs);
  #   nixPath = [ "/etc/nix/path" ];
  #   settings = {
  #     auto-optimise-store = true;
  #     experimental-features = "nix-command flakes";
  #   };
  #   optimise = {
  #     automatic = true;
  #     dates = [ "weekly" ];
  #   };
  #   gc = {
  #     automatic = true;
  #     dates = "weekly";
  #     options = "-d --repair";
  #   };
  # };

  # environment = {
  #   etc = lib.mapAttrs'
  #   (name: value: {
  #     name = "nix/path/${name}";
  #     value.source = value.flake;
  #   })
  #   config.nix.registry;
  # };

  services = {
    openssh.enable = true;
    printing.enable = true;
    pipewire.enable = true;
    pipewire.alsa.enable = true;
    pipewire.pulse.enable = true;
  };

  i18n.defaultLocale = "en_AU.UTF-8";

  time.timeZone = "Australia/Brisbane";

  networking.networkmanager.enable = true;

  # Recommended for PipeWire
  security.rtkit.enable = true;

  # Disabled for PipeWire
  sound.enable = false;
}
