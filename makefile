PROJECT = IJSRA (admin)
SHELL   = bash
MAKE    = make
NAME   ?= XX
PANDOC_SCHOLAR_PATH_PREFIX = templates/XX-NewProject/system
PANDOC_SCHOLAR_PATH    = $(PANDOC_SCHOLAR_PATH_PREFIX)/pandoc-scholar
# Colors
RED   = \033[0;31m
CYAN  = \033[0;36m
NC    = \033[0m
echoPROJECT = @echo -e "$(CYAN) <$(PROJECT)>$(RED)"

.PHONY: templates test 

templates: cleanpandoc csl get-pandoc-scholar
	for dir in issue-in-progress/*; \
	do \
	echo "$$dir" && \
	cp -a templates/XX-NewProject/system/. $$dir/system/; \
	done
	$(echoPROJECT) "* templates copied * $(NC)"

createproject:
	@cp -r templates/XX-NewProject issue-in-progress/$(NAME) 
	@sed -i '' "1s/NN/$(NAME)/" issue-in-progress/$(NAME)/makefile
	@git add . && git commit -m "$(NAME) added"
	$(echoPROJECT) "New project folder $(NAME) created. $(NC)"	


csl:
	@curl -s https://raw.githubusercontent.com/citation-style-language/styles/master/chicago-author-date.csl >> templates/XX-NewProject/system/csl-styles/chicago-author-date.csl
	$(echoPROJECT) "* csl downloaded  * $(NC)"

cleanpandoc:
	rm -rf $(PANDOC_SCHOLAR_PATH)

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
