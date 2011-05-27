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

MAIN_SOURCE             = Source/Main.texi
ALL_SOURCE              = $(shell find Source/ -type f -name '*.texi' -exec echo "{}" \; | sed 's/ /\\ /g')
UMBRELLO_DIAGRAM        = ../AresEngine/UML/Engine.xmi
PRE_OUTPUT              = Main.pdf
OUTPUT                  = Handbook.pdf
CACHE                   = Cache

# Umbrello can generate only all or none at once, so only need to specify one...
UMBRELLO_DIAGRAM_PDF    = Images/AresEngine/Artificial\ Intelligence.pdf

all: $(OUTPUT)

$(OUTPUT): $(ALL_SOURCE) $(UMBRELLO_DIAGRAM_PDF)
	texi2dvi --pdf -I Images --build-dir=$(CACHE) $(MAIN_SOURCE) && mv $(PRE_OUTPUT) $(OUTPUT)

$(UMBRELLO_DIAGRAM_PDF): $(UMBRELLO_DIAGRAM)
	umbrello --export eps $(UMBRELLO_DIAGRAM) --directory Images/AresEngine
	find Images/AresEngine/ -type f -name '*.eps' -execdir epstopdf {} \;
	@ rm -vf Images/AresEngine/*.eps

clean:
	@ rm -vf $(OUTPUT)
	@ rm -vf Images/AresEngine/*.pdf
	@ rm -vf Images/AresEngine/*.eps

