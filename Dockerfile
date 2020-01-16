FROM rocker/verse:3.3.3

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		# for downloading installation files
		wget \
		# tinytex installation requires perl
		# latexmk is a perl script
		perl 
		# compile PDF from latex files
		# texlive-latex-base \
		# auto compile PDF
		latexmk \
		rubber

# ---> CONTINUE <----
# need to install missing tex packages!

# apt install xzdec ??
# apt install apt-util ??

# tlmgr init-usertree
# tlmgr option repository ftp://tug.org/historic/systems/texlive/2015/tlnet-final 
# tlmgr install beebe

# if still packages missing, use 
# tlmgr search --global --file "/times.sty"
# see https://yihui.org/tinytex/

# install R packages
# ecb

CMD /bin/sh



