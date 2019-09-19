
TARGET=proposal.md
DOCX_TEMPLATE=templates/eu-template-reference.docx
LATEX_TEMPLATE=templates/project-template.tex

SVG=$(wildcard figs/*.svg)

all: pdf

$(SVG:.svg=.png): %.png: %.svg
	inkscape -d 200 --export-png $(@) $(<)

$(SVG:.svg=.pdf): %.pdf: %.svg
	inkscape -d 200 --export-pdf $(@) $(<)



%.docx: %.md
	pandoc $(<) -McodeBlockCaptions=true -MfigureTitle=Figure -MtableTitle=Table -MlistingTitle=Listing -F pandoc-crossref -F pandoc-citeproc -o $(@)  --reference-doc=$(DOCX_TEMPLATE)


%.pdf: %.md
	pandoc $(<) -McodeBlockCaptions=true -MfigureTitle=Figure -MtableTitle=Table -MlistingTitle=Listing -F pandoc-crossref -F pandoc-citeproc -o $(@) --template=$(LATEX_TEMPLATE)




docx: $(SVG:.svg=.png) $(TARGET:.md=.docx)

pdf: $(TARGET:.md=.pdf) $(SVG:.svg=.pdf)

clean:
	rm -f $(SVG:.svg=.pdf) $(SVG:.svg=.png) $(TARGET:.md=.pdf) $(TARGET:.md=.docx)
