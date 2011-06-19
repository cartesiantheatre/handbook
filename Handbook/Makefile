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

CONTEXT_PRODUCT             = Source/Handbook.tex
ALL_SOURCE                  = $(shell find Source/ -type f -name '*.tex' -exec echo "{}" \; | sed 's/ /\\ /g')
UMBRELLO_ENGINE_DIAGRAM     = ../AresEngine/UML/Engine.xmi
OUTPUT                      = Avaneya\ Crew\ Handbook
CACHE                       = Cache
CONTEXT_OPTIONS             = --purgeresult --nonstopmode

# Umbrello can generate only all or none at once, so only need to specify one...
UMBRELLO_ENGINE_DIAGRAM_SVG = Images/AresEngine/Engine.svg

all: $(OUTPUT) Makefile

$(OUTPUT): $(ALL_SOURCE) $(UMBRELLO_ENGINE_DIAGRAM_SVG)
	context $(CONTEXT_PRODUCT) --result=$(OUTPUT) $(CONTEXT_OPTIONS)

$(UMBRELLO_ENGINE_DIAGRAM_SVG): $(UMBRELLO_ENGINE_DIAGRAM)
#	umbrello --export svg $(UMBRELLO_ENGINE_DIAGRAM) --directory Images/AresEngine 1> /dev/null
#	find Images/AresEngine/ -type f -name '*.eps' -execdir epstopdf {} \;
#	@ rm -vf Images/AresEngine/*.eps

clean:
	@ context --purgeall --nonstopmode --noconsole #&> /dev/null
	@ rm -vf $(OUTPUT).pdf
	@ rm -vf Images/AresEngine/*.svg

