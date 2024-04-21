#!/bin/bash
butler push builds/$1 bliznyuknm/vampire-reflector:$1 --userversion-file=version.txt
