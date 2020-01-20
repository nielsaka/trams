FROM rocker/verse:3.3.3

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		xzdec \
		# for downloading installation files
		wget \
		# tinytex installation requires perl
		# latexmk is a perl script
		perl \
		# compile PDF from latex files
		# texlive-latex-base \
		# auto compile PDF
		latexmk \
		rubber \
#
# install R packages
# ecb	
	&& install2.r \
		ecb \
#
# install tex packages
#
	&& tlmgr init-usertree \	
	&& tlmgr option repository ftp://tug.org/historic/systems/texlive/2015/tlnet-final \
	&& tlmgr install beebe

################
# tex packages #
################

# need to install missing tex packages? 
# So far, no need for rocker/verse.

# But in case it's necessary, see
# see https://yihui.org/tinytex/ for details.

# for finding required package from error message
# tlmgr search --global --file "/times.sty"

# apt-get install install xzdec

# tlmgr init-usertree
# tlmgr install beebe (e.g. required for humannat.bst)


CMD /bin/sh



