# This is part of the Avaneya Project Crew Handbook.
# Copyright (C) 2010-2018 Cartesian Theatre™ <info@cartesiantheatre.com>.
# See the file Copying for details on copying conditions.

CONTEXT_PRODUCT         = Handbook.tex
ALL_TEX_SOURCE          = $(shell find . -type f -iname '*.tex' -exec echo "{}" \; | sed 's/ /\\ /g')
ALL_DOT_PDF             = $(patsubst %.dot.gv, %.pdf, $(shell find . -type f -iname '*.dot.gv' -exec echo "{}" \; | sed 's/ /\\ /g'))
ALL_TWOPI_PDF           = $(patsubst %.twopi.gv,%.pdf, $(shell find . -type f -iname '*.twopi.gv' -exec echo "{}" \; | sed 's/ /\\ /g'))
ALL_BIBTEX              = References/References.bib
ALL_GRAPHVIZ_PDF        = $(ALL_DOT_PDF) $(ALL_TWOPI_PDF)
# Override path with make UMBRELLO_ENGINE_DIAGRAM='/home/kip/Projects/Avaneya/OldMonolithicBzr/Documentation/Contributors/AresEngine/UML/Engine.xmi'
UMBRELLO_ENGINE_DIAGRAM = ../AresEngine/UML/Engine.xmi
CONTEXT_OPTIONS         = --purgeresult --directives=logs.blocked,system.nostatistics #--nostats --batchmode --engine=luajittex 

# Major PDF's output targets...
TOC_PDF                 = Table_of_Contents.pdf
OUTPUT_PDF              = Avaneya_Project_Crew_Handbook.pdf
VIKING_PDF              = Viking_Lander_Remastered.pdf

# Umbrello can only export all or none of its diagrams, so we specify an 
#  arbitrary one to trigger exporting all of them...
UMBRELLO_ENGINE_DIAGRAM_SVG = Engineer_Contributors/Images/AresEngine/Engine.svg

# Generate handbook PDF, but also check if this makefile is updated...
all: $(OUTPUT_PDF) Makefile

# Generate handbook PDF...
$(OUTPUT_PDF): ${ALL_DOT_PDF} $(ALL_TWOPI_PDF) $(ALL_TEX_SOURCE) $(UMBRELLO_ENGINE_DIAGRAM_SVG) ${ALL_BIBTEX}
	context $(CONTEXT_PRODUCT) --result=$(OUTPUT_PDF) $(CONTEXT_OPTIONS)

# Generate all graphviz diagrams...
graphviz: ${ALL_DOT_PDF} $(ALL_TWOPI_PDF)

# Export engine diagram images. Invoked via xvfb because Umbrello can't run 
#  headless: <https://bugs.kde.org/show_bug.cgi?id=283748>
$(UMBRELLO_ENGINE_DIAGRAM_SVG): $(UMBRELLO_ENGINE_DIAGRAM)
	xvfb-run umbrello --export svg $(UMBRELLO_ENGINE_DIAGRAM) --directory Engineer_Contributors/Images/AresEngine

# Just produce the table of contents...
toc: $(TOC_PDF)
$(TOC_PDF): $(OUTPUT_PDF)
	pdftk A=$(OUTPUT_PDF) cat A3-16 output $@

# Just produce the Viking Lander Remastered chapter...
vlr: graphviz $(VIKING_PDF)
$(VIKING_PDF): $(ALL_TEX_SOURCE) $(UMBRELLO_ENGINE_DIAGRAM_SVG) ${ALL_BIBTEX}
	context Viking_Lander_Remastered/Viking_Lander_Remastered.tex --result=$@ $(CONTEXT_OPTIONS) --environment=Viking_Lander_Remastered/Standalone_Environment.tex

# Clean everything, including the cached engine diagram images...
clean: mostlyclean
	@ rm -vf Engineer_Contributors/Images/AresEngine/*.svg
	@ find . -type f -iname "m_k_i_v_*.pdf" -execdir rm -v {} \;
	@ rm -vf ${ALL_GRAPHVIZ_PDF}

# Graphviz dotty source file to pdf...
%.pdf: %.dot.gv
	dot -Tpdf $< -o $@

# Graphviz twopi source file to pdf...
%.pdf: %.twopi.gv
	twopi -Tpdf $< -o $@

# Clean most intermediate build files, including the generated PDF...
mostlyclean:
	@ rm -vf $(OUTPUT_PDF)
	@ rm -vf Handbook.pdf Handbook.aux Handbook.blg Handbook.bbl
	@ rm -vf $(VIKING_PDF)
	@ rm -vf $(TOC_PDF)
	@ context --purgeall --nonstopmode --noconsole &> /dev/null

# Upload...
upload: $(OUTPUT_PDF)
	rsync -avz --progress --partial $(OUTPUT_PDF) "avaneya@avaneya.com:/home/avaneya/avaneya.com/downloads/"

# Directive to make to let it know that these targets don't generate filesystem 
#  objects / products and therefore no need to check time stamps...
.PHONY: all clean clean-all graphviz toc upload vlr

