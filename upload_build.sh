#!/bin/bash
butler push builds/$1 bliznyuknm/hell-of-mirrors:$1 --userversion-file=version.txt
