# makefile pro preklad LaTeX verze Bc. prace
# makefile for compilation of the thesis
# (c) 2008 Michal Bidlo
# E-mail: bidlom AT fit vutbr cz
# Edited by: dytrych AT fit vutbr cz
#===========================================
# asi budete chtit prejmenovat / you will probably rename:
CO=xkabel09-Digitalni-zvukova-steganografie
FJ=/usr/bin/firejail --profile=latex --disable-mnt --whitelist="$(shell pwd)" --blacklist="$(shell pwd)"/.git --private-bin=pdflatex,bibtex,latex,dvips

all: $(CO).pdf

pdf: $(CO).pdf

$(CO).ps: $(CO).dvi
	$(FJ) dvips $(CO)

$(CO).pdf: clean
	$(FJ) pdflatex $(CO)
	-$(FJ) bibtex $(CO)
	$(FJ) pdflatex $(CO)
	$(FJ) pdflatex $(CO)

$(CO).dvi: $(CO).tex $(CO).bib
	$(FJ) latex $(CO)
	-$(FJ) bibtex $(CO)
	$(FJ) latex $(CO)
	$(FJ) latex $(CO)

clean:
	rm -f *.dvi *.log $(CO).blg $(CO).bbl $(CO).toc *.aux $(CO).out $(CO).lof $(CO).ptc
	rm -f $(CO).pdf
	rm -f *~

pack:
	git restore --source make -- Makefile
	tar czvf $(CO).tar.gz *.tex *.bib template-fig/* obrazky/* bib-styles/* fitthesis.cls zadani.pdf $(CO).pdf Makefile
	git restore --source master -- Makefile

rename:
	mv $(CO).tex $(NAME).tex
	mv $(CO)-01-kapitoly-chapters.tex $(NAME)-01-kapitoly-chapters.tex
	mv $(CO)-01-kapitoly-chapters-en.tex $(NAME)-01-kapitoly-chapters-en.tex
	mv $(CO)-20-literatura-bibliography.bib $(NAME)-20-literatura-bibliography.bib
	mv $(CO)-30-prilohy-appendices.tex $(NAME)-30-prilohy-appendices.tex
	mv $(CO)-30-prilohy-appendices-en.tex $(NAME)-30-prilohy-appendices-en.tex
	sed -i "s/$(CO)-01-kapitoly-chapters/$(NAME)-01-kapitoly-chapters/g" $(NAME).tex
	sed -i "s/$(CO)-01-kapitoly-chapters-en/$(NAME)-01-kapitoly-chapters-en/g" $(NAME).tex
	sed -i "s/$(CO)-20-literatura-bibliography/$(NAME)-20-literatura-bibliography/g" $(NAME).tex
	sed -i "s/$(CO)-30-prilohy-appendices/$(NAME)-30-prilohy-appendices/g" $(NAME).tex
	sed -i "s/$(CO)-30-prilohy-appendices-en/$(NAME)-30-prilohy-appendices-en/g" $(NAME).tex
	sed -i "s/$(CO)/$(NAME)/g" Makefile
	
# Pozor, vlna neresi vse (viz popis.txt) / Warning - vlna is not solving all problems (see description.txt)
vlna:
	vlna -l $(CO)-*.tex

# Spocita normostrany / Count of standard pages
normostrany:
	/usr/bin/firejail --quiet --profile=zathura --private-bin=pdftotext pdftotext -nopgbrk $(CO).pdf - | sed -n '/^Kapitola 1$$/,/^Literatura$$/p' | wc -c | xargs printf "scale=2; %s/1800;\n" | bc

