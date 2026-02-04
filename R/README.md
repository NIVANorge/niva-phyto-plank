# R scripting

We got some libraries specific for phytoplankton science. The main one being nivaPhytoPlankton. This can be used locally or in Jupyterhub.

## Install locally

To install locally there are certain preconditions that must be fulfilled. Firstly you must have an Oracle client installed. This is done through Company Portal. Secondly you must install git and have credentials for Github.

Then you should be able to run this code:

``` r
install.packages("devtools")
remotes::install_github("NIVANorge/niva-phyto-plank", subdir="R/nivaPhytoPlankton")
```

The you can look at [this](examples/nivaPhytoPlankton.Rmd) example.

## Run in Jupyterhub

In Jupyerhub there shouldn't be a need to install anything. The examples folder is copied into:

`shared/common/Phytoplankton`
