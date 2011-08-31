# Avaneya Project Crew Handbook
# Copyright (C) 2010, 2011 Kshatra Corp <kip@thevertigo.com>.
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
OUTPUT                      = Avaneya\ Project\ Crew\ Handbook.pdf
CONTEXT_OPTIONS             = --purgeresult --nonstopmode #--nostats

# Umbrello can only export all or none of its diagrams, so we specify 
#  an arbitrary one...
UMBRELLO_ENGINE_DIAGRAM_SVG = Source/Information_For_Engineers/Images/AresEngine/Engine.svg

# Generate handbook PDF, but also check if this makefile is updated...
all: $(OUTPUT) Makefile

# Generate handbook PDF...
$(OUTPUT): $(ALL_SOURCE) $(UMBRELLO_ENGINE_DIAGRAM_SVG)
	context $(CONTEXT_PRODUCT) --result=$(OUTPUT) $(CONTEXT_OPTIONS)

# Export engine diagram images...
$(UMBRELLO_ENGINE_DIAGRAM_SVG): $(UMBRELLO_ENGINE_DIAGRAM)
	umbrello --export svg $(UMBRELLO_ENGINE_DIAGRAM) --directory Source/Information_For_Engineers/Images/AresEngine 1> /dev/null

# Just produce the information for artists chapter...
Artists.pdf: $(ALL_SOURCE) $(UMBRELLO_ENGINE_DIAGRAM_SVG)
	context Source/Information_For_Artists/Information_For_Artists.tex --result=$@ --purgeresult --nonstopmode --environment=Source/Environment.tex

# Clean everything, including the cached engine diagram images...
clean-all: clean
	@ rm -vf Source/Information_For_Engineers/Images/AresEngine/*.svg
	@ find . -type f -iname "m_k_i_v_*.pdf" -execdir rm -v {} \;

# Clean most intermediate build files, including the generated PDF...
clean:
	@ context --purgeall --nonstopmode --noconsole &> /dev/null
	@ rm -vf $(OUTPUT) Handbook.pdf

