#!/bin/bash
# xsd2swift: Command line tool to convert XML schemas to Swift classes.
# Copyright (C) 2017  Steven E Wright
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd); cd $SCRIPT_DIR
GIT_ROOT=$(git rev-parse --show-cdup); cd ./$GIT_ROOT

./build.sh
cp out/xsd2swift /usr/local/bin/
