FROM rocker/verse:3.3.3

ENV TEXMFHOME="/opt/tinytex/"

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		xzdec \
		## for downloading installation files
		# wget \
		## tinytex installation requires perl
		## latexmk is a perl script
		# perl \
		## compile PDF from latex files
		# texlive-latex-base \
		# auto compile PDF
		latexmk \
		rubber \
##############
# R packages #
##############
	&& install2.r \
		# for fetching data from ECB SDW
		ecb \
		tictoc \
################
# tex packages #
################
# need to install missing tex packages? 
# So far, no need for rocker/verse.
#
# But in case it's necessary, see
# see https://yihui.org/tinytex/ for details.
#
# for finding required package from error message
# tlmgr search --global --file "/times.sty"
# 
# change home dir of texmf, otherwise bound to
# root user; does not work with singularity
	# change directory permanently
	&& tlmgr conf texmf TEXMFHOME "$TEXMFHOME" \
	&& tlmgr init-usertree \	
	&& tlmgr option repository ftp://tug.org/historic/systems/texlive/2015/tlnet-final \
	# for humannat.bst
	&& tlmgr install beebe

CMD /bin/sh



