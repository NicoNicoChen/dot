{
  pkgs ? import <nixpkgs> { },
}:
pkgs.mkShell {
  packages = with pkgs; [
    R
    rstudio
    rPackages.rstudioapi
    rPackages.tidyverse
    rPackages.tidymodels
    rPackages.openxlsx
    rPackages.dplyr
    rPackages.tidyr
    rPackages.stringr
    rPackages.lubridate
    rPackages.ggplot2
    rPackages.car
    rPackages.mgcv
    rPackages.lme4
    rPackages.nlme
    rPackages.randomForest
    rPackages.glmnet
    rPackages.survival
    rPackages.caret
    rPackages.zoo
    rPackages.xts
    rPackages.data_table
    rPackages.tidyjson
    rPackages.devtools
  ];
  shellHook = ''
    echo ""
    echo "====================================="
    echo "= R development environment loaded. ="
    echo "====================================="
    echo ""
    echo "Use 'rstudio > /dev/null 2>&1 &' to launch RStudio."
    echo ""
  '';
}
