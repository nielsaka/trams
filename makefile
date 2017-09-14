PAPER_DIR  = paper
PAPER_FILE = article
PAPER_DEP  = $(PAPER_DIR)/.paper.d
.PHONY: init paper clean cleanall

all: paper

paper: $(PAPER_DIR)/$(PAPER_FILE).pdf

init: 
	make -t
	rm paper/article.pdf
	make -t presentation
	rm presentations/presentation.pdf

$(PAPER_DIR)/$(PAPER_FILE).pdf: paper/$(PAPER_FILE).tex
	latexmk -cd -pdf -deps-out=$(PAPER_DEP) $<
	# write all project specific dependencies to $(PAPER_DEP)
	sed 's/$(PAPER_FILE).pdf/$(PAPER_DIR)\/$(PAPER_FILE).pdf/' $(PAPER_DEP) > tmp.d
	sed -n '1,2p' tmp.d > $(PAPER_DEP)
	grep 'paper/inputs/' tmp.d >> $(PAPER_DEP); rm tmp.d
	perl -pi -e 's/.*(?=$(PAPER_DIR)\\/inputs)/ /' $(PAPER_DEP)

$(PAPER_DIR)/inputs/%.tex: code/%.R
	cd code; Rscript $*.R
	
clean: 
	rm -f *.aux *.bbl *.blg *.log *.bak *~ *.Rout */*~ */*.Rout */*.aux \
	*/*.log	*/*.bbl

cleanall: 
	\rm -f *.aux *.bbl *.blg *.log *.pdf *.bak *~ *.Rout */*~ */*.Rout \
	*/*.pdf	*/*.aux */*.log

-include $(PAPER_DEP)