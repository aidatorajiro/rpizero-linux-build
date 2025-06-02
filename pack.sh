#!/bin/bash

set -e

cd install
tar Jcvf ../install.tar.xz boot/* lib/modules
