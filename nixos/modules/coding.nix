{ pkgs, nixpkgs-master, ... }: {

  environment.systemPackages = with pkgs; [
    neovim
    git
    lazygit
    gh
    gcc
    gnumake
    nodejs
    go
    cargo
    luarocks
    tree-sitter
    jdk
    python3
    sbt
    coursier
    corepack
    dart-sass
    delta
    redis
    nixpkgs-master.legacyPackages."${pkgs.system}".bloop
  ];

  services.redis.servers."".enable = true;
}
