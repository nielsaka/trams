PAPER_DIR = paper
PAPER_DEP = paper/.paper.d
.PHONY: init

all: paper

paper: paper/article.pdf

init: 
	make -t
	rm paper/article.pdf
	make -t presentation
	rm presentations/presentation.pdf

paper/article.pdf: paper/article.tex
	latexmk -cd -pdf -deps-out=$(PAPER_DEP) $<
	# exclude all non-project-specific dependencies
	sed 's/article.pdf/paper\/article.pdf/' $(PAPER_DEP) > tmp.d
	sed -n '1,2p' tmp.d > $(PAPER_DEP)
	grep 'paper/inputs/' tmp.d >> $(PAPER_DEP)
	rm tmp.d 
	perl -pi -e 's/.*(?=paper\\/inputs)//' $(PAPER_DEP)

paper/inputs/%.tex: code/%.R
	cd code; Rscript $*.R
	
clean: 
	rm -f *.aux *.bbl *.blg *.log *.bak *~ *.Rout */*~ */*.Rout */*.aux \
	*/*.log	*/*.bbl

cleanall: 
	\rm -f *.aux *.bbl *.blg *.log *.pdf *.bak *~ *.Rout */*~ */*.Rout \
	*/*.pdf	*/*.aux */*.log

-include $(PAPER_DEP)