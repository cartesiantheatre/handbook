# Avaneya Crew Handbook
# Copyright (C) 2011 Kshatra Corp <kip@thevertigo.com>.
#
# Public discussion on IRC available at #avaneya (irc.freenode.net) or
# on the mailing list <avaneya@lists.avaneya.com>.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or 
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful, but 
# WITHOUT ANY WARRANTY; without even the implied warranty of 
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU 
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

MAIN_SOURCE = Source/Handbook.texi
ALL_SOURCE  = Source/Licenses/GFDL.texi \
              Source/Licenses/GPL.texi  \
              Source/Handbook.texi      \
              Source/Version.texi
OUTPUT      = Handbook.pdf
CACHE       = Cache

all: $(OUTPUT)

$(OUTPUT): $(ALL_SOURCE)
	texi2pdf -q --build-dir=$(CACHE) $(MAIN_SOURCE)

clean:
	@ texi2pdf -q --clean $(MAIN_SOURCE)
	@ rm -vf $(OUTPUT)

