PROJECT  =Ellis
SHELL = bash
MAKE  = make
WHOAMI = $(shell whoami)
#IN = $(PROJECT)
IN    :=$(if $(IN),$(IN),content/$(PROJECT))
OUT   ?=$(IN)
OUTDIR := $(dir $(OUT))
OUTFILE := $(notdir $(OUT))
DOCX = archive/$(PROJECT)
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
OUTFILE_PREFIX      ?= ./$(PROJECT)-IJSRA
PANDOC_SCHOLAR_PATH_PREFIX = system
PANDOC_SCHOLAR_PATH = $(PANDOC_SCHOLAR_PATH_PREFIX)/pandoc-scholar
PANDOC_LATEX_OPTIONS  +=  --pdf-engine=lualatex
TEMPLATE_FILE_LATEX = system/ijsra.latex
DEFAULT_EXTENSIONS    = latex pdf


# checking if pandoc-scholar is available
ifeq ($(wildcard $(PANDOC_SCHOLAR_PATH)),)
all: 
	$(echoPROJECT) "* pandoc-scholar is not detected. Downloading now. * $(NC)"
	@$(MAKE) install
else
include $(PANDOC_SCHOLAR_PATH)/Makefile
endif



docx2md:
	pandoc -s $(DOCX).docx -t markdown -o archive/$(OUTFILE)-raw.md
	$(MAKE) cleanmd
	$(echoPROJECT) "* conversion .docx to .md finished * $(NC)"
cleanmd:
	$(shell perl -0777 -pe 's/\\\[\\\[/\[\@/g' archive/$(OUTFILE)-raw.md  > $(TEMP)/1.md)	
	$(shell perl -0777 -pe 's/\\\]\\\]/\]/g'  $(TEMP)/1.md  >  content/$(OUTFILE).md)


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
	install -d -m 0777 $(PANDOC_SCHOLAR_PATH)
	@unzip -qq pandoc-scholar.zip -d $(PANDOC_SCHOLAR_PATH_PREFIX)/
	@rm -f pandoc-scholar.zip*	
	$(echoPROJECT) "* pandoc-scholar installed * $(NC)"
