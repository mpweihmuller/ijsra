PROJECT  =ijsra
SHELL = bash
MAKE  = make
WHOAMI = $(shell whoami)
IN    :=$(if $(IN),$(IN),content/$(PROJECT))
OUT   ?=$(IN)
OUTDIR := $(dir $(OUT))
OUTFILE := $(notdir $(OUT))
# zip
PWD   = $(shell pwd)
TEMP := $(shell mktemp -d -t tmp.XXXXXXXXXX)
TDIR  = $(TEMP)/$(PROJECT)
VERS  = $(shell /bin/date "+%Y-%m-%d---%H-%M-%S")
DATE  = $(shell /bin/date "+%Y-%m-%d")
# Colors
RED   = \033[0;31m
CYAN  = \033[0;36m
NC    = \033[0m
echoPROJECT = @echo -e "$(CYAN) <$(PROJECT)>$(RED)"

########
ARTICLE_FILE        ?= $(IN).md
OUTFILE_PREFIX      ?= $(IN)
PANDOC_SCHOLAR_PATH_PREFIX = /usr/local
PANDOC_SCHOLAR_PATH = $(PANDOC_SCHOLAR_PATH_PREFIX)/pandoc-scholar
PANDOC_LATEX_OPTIONS   =  --pdf-engine=lualatex
PANDOC_WRITER_OPTIONS += $(IN).yaml
# TEMPLATE_FILE_LATEX = $(PROJECT)-template.latex

# checking if pandoc-scholar is available
ifeq ($(wildcard $(PANDOC_SCHOLAR_PATH)),)
all: 
	$(echoPROJECT) "* pandoc-scholar is not detected. Downloading now. * $(NC)"
	@$(MAKE) install
else
include $(PANDOC_SCHOLAR_PATH)/Makefile
endif

########
.PHONY: test


test:

docx2md:
	pandoc -s $(IN).docx -t markdown -o archive/$(OUTFILE)-raw.md
	$(MAKE) cleanmd
	$(echoPROJECT) "* conversion .docx to .md finished * $(NC)"
cleanmd:
	$(shell perl -0777 -pe 's/\\\[\\\[/\[\@/g' archive/$(OUTFILE)-raw.md  > $(TEMP)/1.md)	
	$(shell perl -0777 -pe 's/\\\]\\\]/\]/g'  $(TEMP)/1.md  >  content/$(OUTFILE).md)

# clean not needed files
cleanup: 
	@rm -f $(PROJECT).{xdv,aux,mw,bbl,bcf,blg,doc,fls,glo,gls,hd,idx,ilg,ind,\
		listing,log,nav,out,run.xml,snm,synctex.gz,toc,vrb}
	@rm -f *.fdb_latexmk
	@rm -f *.fls
	@rm -f *.run.xml
	@rm -f *.blg
	@rm -f *.toc
	@rm -f *.glo
	@rm -f *.pkglist
	@rm -f *.ins
	@rm -f *.bbl
	@rm -f *.listing
	@rm -f *.bcf	
	@rm -f $(PROJECT).markdown.{in,lua,out}
	@rm -f *.{log,aux}
	@rm -rf _markdown_*
	$(echoPROJECT) "* cleaned temp files * $(NC)"

# clean all
cleanbundle: cleanup
	@rm -f *.{{b,c,d,l}bx,bib,ins,pdf,zip,cls,latex}
	@rm -f *-style.sty
	$(echoPROJECT) "* all files cleaned * $(NC)"


install: install-full
	$(MAKE) get-pandoc-scholar
	# $(MAKE) setup-folder
	$(echoPROJECT) "* edition-topoi-plus installed * $(NC)"

install-full:
	$(echoPROJECT) "* installing needed programs and files * $(NC)"
	@which brew || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	@which wget || brew install wget
	@brew list pandoc || brew install pandoc
	$(echoPROJECT) "* edition-topoi-plus fully installed * $(NC)"

# setup-folder:
# 	@-mkdir project project/bibliography project/csl-styles
# 	# git clone https://github.com/citation-style-language/styles.git project/csl-styles
# 	# @curl -s https://raw.githubusercontent.com/citation-style-language/styles/master/deutsches-archaologisches-institut.csl >> project/csl-styles/deutsches-archaologisches-institut.csl
# 	$(echoPROJECT) "* folder setup completed  * $(NC)"


get-pandoc-scholar:
	@curl -s https://api.github.com/repos/pandoc-scholar/pandoc-scholar/releases/latest \
	| grep "browser_download_url.*zip" \
	| cut -d : -f 2,3 \
	| tr -d '"' \
	| wget -qi -
	sudo install -d -m 0777 $(PANDOC_SCHOLAR_PATH)
	@unzip -qq pandoc-scholar.zip -d $(PANDOC_SCHOLAR_PATH_PREFIX)/
	@rm -f pandoc-scholar.zip*	
	$(echoPROJECT) "* pandoc-scholar installed * $(NC)"

# zip files for sending etc.
zip:
	$(echoPROJECT) "* start zipping files * $(NC)"
	@-mkdir archive
	@rm -f archive/$(PROJECT)-$(DATE)*.zip
	@mkdir $(TDIR)
	@cp $(PROJECT).{bib,tex,pdf,csv} README.md makefile $(TDIR)
	@cd $(TEMP); \
   zip -Drq $(PWD)/archive/$(PROJECT)-$(VERS).zip $(PROJECT)
	$(echoPROJECT) "* files zipped * $(NC)"

# minimize PDF
minimize:
	$(echoPROJECT) "* minimizing article * $(NC)"
	@-mkdir archive
	@rm -f archive/$(PROJECT)-$(DATE)*.pdf
	gs \
   -sDEVICE=pdfwrite \
   -dCompatibilityLevel=1.4 \
   -dPDFSETTINGS=/printer \
   -dNOPAUSE \
   -dQUIET \
   -dBATCH \
   -sOutputFile=archive/$(PROJECT)-$(VERS).pdf \
  $(PROJECT).pdf
	$(echoPROJECT) "* article minimized * $(NC)"

# count pages with colors
count.colorpages:
	$(echoPROJECT) "* listing and counting colored pages * $(NC)"
	@echo "Meta information about colors in $(PROJECT)"
	@gs -o - -sDEVICE=inkcov $(PROJECT).pdf \
   | tail -n +5 \
   | sed '/^Page*/N;s/\n//' \
   | tee $(PROJECT).csv
	@echo -n "List of pages with colors: "
	@cat $(PROJECT).csv \
   | awk '$$3!="0.00000" ||  $$4!="0.00000" || $$5!="0.00000"{if(length(colored))colored=colored","$$2;else colored=$$2} END{print colored}' \
   | tee  -a $(PROJECT).csv
	@echo -n "Total amount of pages with color: "
	@gs -o - -sDEVICE=inkcov $(PROJECT).pdf \
   | grep -v "^ 0.00000  0.00000  0.00000" \
   | grep "^ " \
   | wc -l \
   | sed 's/[[:space:]]//g' \
   | tee  -a $(PROJECT).csv
	$(echoPROJECT) "* colored pages listed and counted * $(NC)"
