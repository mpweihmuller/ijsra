PROJECT  =Ellis
SHELL = bash
MAKE  = make
WHOAMI = $(shell whoami)
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
OUTFILE_PREFIX      ?= $(IN)
PANDOC_SCHOLAR_PATH_PREFIX = /usr/local
PANDOC_SCHOLAR_PATH = $(PANDOC_SCHOLAR_PATH_PREFIX)/pandoc-scholar
PANDOC_LATEX_OPTIONS  +=  --pdf-engine=lualatex
TEMPLATE_FILE_LATEX = ijsra.latex
# PANDOC_WRITER_OPTIONS  = --standalone
# PANDOC_WRITER_OPTIONS += --filter=pandoc-citeproc
# PANDOC_WRITER_OPTIONS += --metadata-file=data/metadata.yaml 


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
