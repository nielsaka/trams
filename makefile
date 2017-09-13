all: paper

paper: 2_paper/article.pdf

2_paper/article.pdf: 2_paper/article.tex 2_paper/lit_all.bib
	cd 2_paper; latexmk -pdf article.tex
	
# Figs/fig1.pdf: R/R_fig.R 
	# cd R;R CMD BATCH '--args eps=FALSE' R_fig.R

# Figs/fig1.eps: R/R_fig.R 
	# cd R;R CMD BATCH '--args eps=TRUE' R_fig.R

clean: 
	rm -f *.aux *.bbl *.blg *.log *.bak *~ *.Rout */*~ */*.Rout */*.aux */*.log */*.bbl

cleanall: 
	\rm -f *.aux *.bbl *.blg *.log *.pdf *.bak *~ *.Rout */*~ */*.Rout */*.pdf */*.aux */*.log