# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
    
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Vienna";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_AT.UTF-8";
    LC_IDENTIFICATION = "de_AT.UTF-8";
    LC_MEASUREMENT = "de_AT.UTF-8";
    LC_MONETARY = "de_AT.UTF-8";
    LC_NAME = "de_AT.UTF-8";
    LC_NUMERIC = "de_AT.UTF-8";
    LC_PAPER = "de_AT.UTF-8";
    LC_TELEPHONE = "de_AT.UTF-8";
    LC_TIME = "de_AT.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
 

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.max = {
    isNormalUser = true;
    description = "max";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
    
  };

  # Java
  programs.java = {
  	enable = true;
  	package = pkgs.jdk21;
  };

  

  # Install firefox.
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Optional: for Steam Remote Play
    dedicatedServer.openFirewall = true; # Optional: for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Optional: for local network game transfers
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
	git
	openjdk21
	pavucontrol
	firefox
	fish
	jre21_minimal
	jre_minimal
	jdk
	jdk24
	vscode
	neovim
	gedit
	xdg-utils
	waypaper
	vim
	micro
	hyprland
	libreoffice-qt6
	jetbrains-toolbox
	jetbrains.idea-ultimate
	kitty
	waybar
	(waybar.overrideAttrs (oldAttrs: {
		mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
		})
	)
	eww
	swww
	mako
	dunst
	libnotify
	hyprpaper
	swaybg
	wpaperd
	mpvpaper
	rofi-wayland
	wofi
	fuzzel
	tofi
	bibata-cursors
	nerdfetch
	prismlauncher
	(prismlauncher.override {
		additionalPrograms = [ffmpeg];

		jdks = [
			graalvm-ce
			zulu8
			zulu17
			zulu
		];
	})
	nerd-fonts.jetbrains-mono
	nerd-fonts.fira-code
	steam
	steam-run
	alsa-utils
	alacritty
	alacritty-theme
	zed
	vscodium
	vscode
	kdePackages.kate
	libsForQt5.kate
	grim
	grimblast
	wl-clipboard
    slurp
    swappy
    hyprshot
    hyprlock
    hypridle
    xwayland
    nixd
    git-lfs
    direnv
    gradle
    maven
    kdePackages.kdesu
    pipewire
    playerctl
    qt6.qtwayland
    font-manager
    lxappearance
    gamescope
    protonup
    starship
    btop
    brave
    librewolf
    vesktop
    minecraftia
    atlauncher
    python314
    pipx
    python3Packages.pip
  ];
  programs.firefox.enable = true;
	
  programs.fish.enable = true;

  #Fonts
  fonts.fontDir.enable = true;
  

  #Hyprland
  programs.hyprland = {
	enable = true;
	xwayland.enable = true;
  };

  environment.sessionVariables = {
	WLR_NO_HARDWARE_CURSORS = "1";
	NIXOS_OZONE_WL = "1";
  };

  hardware = {
	graphics.enable = true;
	nvidia.modesetting.enable = true;
	nvidia.open = false;
  };
  services.xserver.videoDrivers = ["nvidia"];
  

  #XDG
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?


  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
      kwallet
      kwallet-pam
      kwalletmanager
      okular
  ];
}
