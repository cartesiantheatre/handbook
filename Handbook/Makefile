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

MAIN_SOURCE = Source/Main.texi
ALL_SOURCE  = $(shell find Source/ -type f -name '*.texi' -exec echo "{}" \; | sed 's/ /\\ /g')
PRE_OUTPUT  = Main.pdf
OUTPUT      = "Avaneya Crew Handbook.pdf"
CACHE       = Cache

all: $(OUTPUT)

$(OUTPUT): $(ALL_SOURCE)
	texi2dvi --pdf --build-dir=$(CACHE) $(MAIN_SOURCE) && mv $(PRE_OUTPUT) $(OUTPUT)

clean:
	@ rm -vf $(OUTPUT)


