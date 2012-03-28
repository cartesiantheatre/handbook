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

CONTEXT_PRODUCT         = Source/Handbook.tex
ALL_TEX_SOURCE          = $(shell find Source/ -type f -iname '*.tex' -exec echo "{}" \; | sed 's/ /\\ /g')
ALL_DOT_PDF             = $(patsubst %.dot.gv, %.pdf, $(shell find Source/ -type f -iname '*.dot.gv' -exec echo "{}" \; | sed 's/ /\\ /g'))
ALL_TWOPI_PDF           = $(patsubst %.twopi.gv,%.pdf, $(shell find Source/ -type f -iname '*.twopi.gv' -exec echo "{}" \; | sed 's/ /\\ /g'))
ALL_GRAPHVIZ_PDF        = $(ALL_DOT_PDF) $(ALL_TWOPI_PDF)
UMBRELLO_ENGINE_DIAGRAM = ../AresEngine/UML/Engine.xmi
OUTPUT                  = Avaneya\ Project\ Crew\ Handbook.pdf
CONTEXT_OPTIONS         = --purgeresult --batchmode --directives=logs.blocked,system.nostatistics #--nostats

# Umbrello can only export all or none of its diagrams, so we specify an 
#  arbitrary one...
UMBRELLO_ENGINE_DIAGRAM_SVG = Source/Contributors/Engineers/Images/AresEngine/Engine.svg

# Generate handbook PDF, but also check if this makefile is updated...
all: $(OUTPUT) Makefile

# Generate handbook PDF...
$(OUTPUT): ${ALL_GRAPHVIZ_PDF} $(ALL_TEX_SOURCE) $(UMBRELLO_ENGINE_DIAGRAM_SVG) Makefile
	context $(CONTEXT_PRODUCT) --result=$(OUTPUT) $(CONTEXT_OPTIONS)

# Generate all graphviz diagrams...
graphviz: ${ALL_DOT_PDF} $(ALL_TWOPI_PDF)

# Export engine diagram images...
$(UMBRELLO_ENGINE_DIAGRAM_SVG): $(UMBRELLO_ENGINE_DIAGRAM)
	umbrello --export svg $(UMBRELLO_ENGINE_DIAGRAM) --directory Source/Contributors/Engineers/Images/AresEngine

# Just produce the Viking Lander Remastered chapter...
Viking_Lander_Remastered.pdf: $(ALL_TEX_SOURCE) $(UMBRELLO_ENGINE_DIAGRAM_SVG)
	context Source/Viking_Lander_Remastered/Viking_Lander_Remastered.tex --result=$@ --purgeresult --nonstopmode --environment=Source/Environment.tex

# Clean everything, including the cached engine diagram images...
clean-all: clean
	@ rm -vf Source/Contributors/Engineers/Images/AresEngine/*.svg
	@ find . -type f -iname "m_k_i_v_*.pdf" -execdir rm -v {} \;
	@ rm -vf ${ALL_GRAPHVIZ_PDF}

# Graphviz dotty source file to pdf...
%.pdf: %.dot.gv
	dot -Tpdf $< -o $@

# Graphviz twopi source file to pdf...
%.pdf: %.twopi.gv
	twopi -Tpdf $< -o $@

# Clean most intermediate build files, including the generated PDF...
clean:
	@ rm -vf $(OUTPUT) Handbook.pdf Viking_Lander_Remastered.pdf
	@ context --purgeall --nonstopmode --noconsole &> /dev/null

