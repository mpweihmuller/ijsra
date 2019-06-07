PROJECT =Ellis
SHELL   = bash
MAKE    = make
WHOAMI  = $(shell whoami)
IN      :=$(if $(IN),$(IN),content/$(PROJECT))
OUT     ?=$(IN)
OUTDIR  := $(dir $(OUT))
OUTFILE := $(notdir $(OUT))
DOCX    ?= archive/$(PROJECT)
TEMP    := $(shell mktemp -d -t tmp.XXXXXXXXXX)
# Colors
RED   = \033[0;31m
CYAN  = \033[0;36m
NC    = \033[0m
echoPROJECT = @echo -e "$(CYAN) <$(PROJECT)>$(RED)"

########################################
ARTICLE_FILE          ?= $(IN).md
OUTFILE_PREFIX        ?= $(PROJECT)-IJSRA
PANDOC_SCHOLAR_PATH_PREFIX = system
PANDOC_SCHOLAR_PATH    = $(PANDOC_SCHOLAR_PATH_PREFIX)/pandoc-scholar
PANDOC_LATEX_OPTIONS  += --biblatex --pdf-engine=latexmk --pdf-engine-opt=-lualatex -outdir=system/.latex
TEMPLATE_FILE_LATEX    = system/ijsra.latex
TEMPLATE_FILE_HTML     = system/ijsra.html
PANDOC_READER_OPTIONS  = data/metadata.yaml
PANDOC_WRITER_OPTIONS  = --standalone
PANDOC_WRITER_OPTIONS += --csl=system/csl-styles/chicago-author-date.csl
PANDOC_WRITER_OPTIONS += --filter=pandoc-citeproc
PANDOC_WRITER_OPTIONS += --lua-filter=$(LUA_FILTERS_PATH)/short-captions/short-captions.lua
DEFAULT_EXTENSIONS     =  latex pdf html epub
########################################


# checking if pandoc-scholar is available
ifeq ($(wildcard $(PANDOC_SCHOLAR_PATH)),)
all: 
	$(echoPROJECT) "* pandoc-scholar is not detected. Downloading now. * $(NC)"
	$(MAKE) get-pandoc-scholar
	$(MAKE)
else
include $(PANDOC_SCHOLAR_PATH)/Makefile
endif



docx2md:
	pandoc --wrap=none -s $(DOCX).docx -t markdown -o archive/$(OUTFILE)-raw.md
	$(MAKE) cleanmd
	$(echoPROJECT) "* conversion .docx to .md finished * $(NC)"
cleanmd:
	$(shell perl -0777 -pe 's/\\@/@/g' archive/$(OUTFILE)-raw.md  > $(TEMP)/1a.md)	
	$(shell perl -0777 -pe 's/\\\[/\[/g' $(TEMP)/1a.md  > $(TEMP)/1.md)	
	$(shell perl -0777 -pe 's/\\\]/\]/g' $(TEMP)/1.md  > $(TEMP)/2.md)	
	$(shell perl -0777 -pe 's/\[\@fig:(.*?)\]/\+fig:$$1/g' $(TEMP)/2.md  > $(TEMP)/3.md)	
	$(shell perl -0777 -pe 's/\[figure-here\\\|(.*?)\\\|(.*?)\\\|(.*?)\\\|(.*?)\\\|(.*?)\]/![$$3](figures\/$$2){#fig:$$2 short-caption="$$4" width=$$5}/g'  $(TEMP)/3.md  >  content/$(OUTFILE).md)

checksystem: csl
	@which brew || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	@brew list pandoc || brew install pandoc
	@which pip || curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
	| python get-pip.py \
	| rm get-pip.py
	@which pantable || pip install pantable
	@which pandoc-crossref || brew install pandoc-crossref
	$(echoPROJECT) "* system checked * $(NC)"

updatesystem: checksystem
	-brew upgrade pandoc
	-brew upgrade pandoc-crossref
	-pip install --upgrade pandoc-pantable
	$(echoPROJECT) "* system updated * $(NC)"$(echoPROJECT) "* edition-topoi-plus fully installed * $(NC)"

csl:
	@-mkdir system system/csl-styles
	@curl -s https://raw.githubusercontent.com/citation-style-language/styles/master/chicago-author-date.csl >> system/csl-styles/chicago-author-date.csl
	$(echoPROJECT) "* csl downloaded  * $(NC)"


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
