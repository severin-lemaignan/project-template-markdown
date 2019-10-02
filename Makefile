
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
	pandoc $(<) --pdf-engine=xelatex -McodeBlockCaptions=true -MfigureTitle=Figure -MtableTitle=Table -MlistingTitle=Listing -F pandoc-wrapfig -F pandoc-crossref -F pandoc-citeproc -o $(@) --template=$(LATEX_TEMPLATE)


%.tex: %.md
	pandoc $(<) -McodeBlockCaptions=true -MfigureTitle=Figure -MtableTitle=Table -MlistingTitle=Listing -F pandoc-wrapfig -F pandoc-crossref -F pandoc-citeproc -o $(@) --template=$(LATEX_TEMPLATE)




docx: $(SVG:.svg=.png) $(TARGET:.md=.docx)

pdf: $(SVG:.svg=.pdf) $(TARGET:.md=.pdf)

tex: $(SVG:.svg=.pdf) $(TARGET:.md=.tex)

clean:
	rm -f $(SVG:.svg=.pdf) $(SVG:.svg=.png) $(TARGET:.md=.pdf) $(TARGET:.md=.docx)
