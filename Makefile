COMMONFORM=node_modules/.bin/commonform
TARGET=document

all: $(TARGET).docx

$(COMMONFORM):
	npm install "commonform-cli@0.11.x"

%.docx: %.cform %.title $(COMMONFORM)
	$(COMMONFORM) render \
		--format docx \
		--number outline \
		--title "$(shell cat $*.title)" \
		< $*.cform \
		> $@

.PHONY: critique lint

critique: $(COMMONFORM)
	$(COMMONFORM) critique < $(TARGET).cform | sort -u

lint: $(COMMONFORM)
	$(COMMONFORM) lint < $(TARGET).cform | sort -u
