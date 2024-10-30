#!/bin/bash

sudo semanage fcontext -a -t container_file_t "$(pwd)(/.*)?"
sudo restorecon -R .
