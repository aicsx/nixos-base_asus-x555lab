{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "axos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  services.pulseaudio.enable = false;

  # 2. Abilita il supporto realtime per i flussi audio (evita lag e stuttering)
  security.rtkit.enable = true;

  # 3. Abilita e configura PipeWire
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # Utilizza WirePlumber per la gestione dinamica delle sorgenti (Sinks)
    wireplumber.enable = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Rome";

 services.xserver = {
    enable = true;
#    autoRepeatDelay = 200;
#    autoRepeatInterval = 35;
    windowManager.qtile = {
      enable = true;
      # Estrae qtile dai pacchetti python e disattiva i test alla radice
      package = pkgs.python3Packages.qtile.overrideAttrs (oldAttrs: {
        doCheck = false;
        checkPhase = "true";
        pytestCheckPhase = "true";
      });
    };
  };

  services.displayManager.ly = {
    enable = true;
    
    # Se utilizzi solo ambienti grafici Wayland puri, puoi impostarlo su false per snellire le dipendenze X11
     #x11Support = true; 

    settings = {
      # Attiva l'animazione "fire" (fuoco) di sottofondo (true / false)
      animation = 2; # 0 per disattivare, 1 per l'effetto fuoco, 2 per Matrix, ecc.

      # Mostra l'orologio standard in alto
      clock = "%c";

      # Mostra un grande orologio ASCII in stile TUI (opzione bigclock)
      #bigclock = true;

      # Salva l'ultimo utente che ha eseguito il login con successo
      save = true;

      # Ricarica automaticamente l'ultimo utente salvato al boot
      load = true;

      # Forza l'attivazione del tasto NumLock all'avvio del display manager
      #numlock = true;

      # Imposta il bordo della scatola di login (0 = nessuno, 1 = linea singola, 2 = doppia linea)
      box_borders = 1;
    };
  };

  # disabilita TPM2 al boot 
  systemd.tpm2.enable = false;
  systemd.units."dev/tpmrm0.device".enable = false;
  security.tpm2.enable = false;
  boot.initrd.systemd.tpm2.enable = false;

  # cancella le versioni precedenti di nix a 30  giorni
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "it_IT.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "it_IT.UTF-8";
    LC_IDENTIFICATION = "it_IT.UTF-8";
    LC_MEASUREMENT = "it_IT.UTF-8";
    LC_MONETARY = "it_IT.UTF-8";
    LC_NAME = "it_IT.UTF-8";
    LC_NUMERIC = "it_IT.UTF-8";
    LC_PAPER = "it_IT.UTF-8";
    LC_TELEPHONE = "it_IT.UTF-8";
    LC_TIME = "it_IT.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "it";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "it";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."ax" = {
    isNormalUser = true;
    description = "ax";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" ];
    packages = with pkgs; [
	net-tools
    pciutils
	];
  };

  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  vim
  ncdu
  fastfetch
  htop
  alacritty
  #niri
  #ghostty
  neovim
  bat
  #fuzzel 
  #swaylock
  #mako 
  #swayidle
  xdg-user-dirs
  pcmanfm
  git
  pulseaudio
  pipewire
  pulsemixer
  pavucontrol
  alsa-utils
  wget
  impression
  ];

programs.git = {
  enable = true;
  config = {
    user = {
      name = "aicsx";
      email = "ax@slackware.eu";
    };
    init = {
      defaultBranch = "main";
    };
  };
};

  # NIRI wm
  #programs.niri.enable = true; 
  
#  services.greetd = {
#	enable = true;
#		settings = {
#	 	default_session = {
#	 		command = "${config.programs.niri.package}/bin/niri-session";
#		user = "ax";
#        };
#     };
#  };

  #systemd.user.services.niri.enableDefaultPath = false;
  ## Niri additional setup
  #security.polkit.enable = true;
  #services.gnome.gnome-keyring.enable = true;
  #security.pam.services.swaylock = {};

  #programs.waybar.enable = true;

  fonts.packages = with pkgs; [
	noto-fonts
	font-awesome
	nerd-fonts.jetbrains-mono
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.bash.promptInit = ''
  # Stile Gentoo: colore diverso per utente (verde) e root (rosso)
  if [ $EUID -eq 0 ]; then
    # Colore rosso per root
    PS1='\[\033[01;31m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
  else
    # Colore verde per utente normale
    PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
  fi
  '';
  
  system.stateVersion = "26.05"; # Did you read the comment?

}
