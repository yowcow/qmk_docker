QMK Build on Ubuntu Docker
==========================

PREREQUISITE
------------

Docker

HOW TO USE
----------

```
% make setup        # builds docker image, clones qmk_firmware repository
% make              # builds firmware
% make clean        # cleans build assets and artifacts
% make realclean    # cleans and removes docker image
```
