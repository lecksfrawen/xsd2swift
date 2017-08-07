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

echo "Formatting Code"
pwd
for DIRECTORY in xsd2swift tests
do
echo "Looking in $DIRECTORY"
    find "$DIRECTORY" \( -name '*.h' -or -name '*.m' \) -print0 | xargs -0 "clang-format" -style=file -i
done
