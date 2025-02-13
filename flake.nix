{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs, ...}: 
    let 
        system = "x86_64-linux";
        pkgs = import nixpkgs { inherit system; config = {}; overlays = []; };
    in {
    devShells.${system}.default = pkgs.mkShellNoCC {
        packages = with pkgs; [
            python3
            python3.pkgs.ipython
            python3.pkgs.manim
            python3.pkgs.moderngl
            python3.pkgs.moderngl-window
            ffmpeg
            libGL
        ];
        LD_LIBRARY_PATH = "$LD_LIBRARY_PATH:${pkgs.libGL}/lib";
        runtimeDependencies = [
            ""
        ];
        shellHook = ''
          ls ${pkgs.libGL}/lib 
          exec zsh
        '';
    };
  };
}
