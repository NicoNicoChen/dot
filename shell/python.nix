{
  pkgs ? import <nixpkgs> { },
}:
pkgs.mkShell {
  packages = with pkgs; [
    uv
  ];
  shellHook = ''
    echo ""
    echo "=========================================="
    echo "= Python development environment loaded. ="
    echo "=========================================="
    echo ""
  '';
}
