TARGET = report.tex
OUT_FORMAT = latex
IN_FORMAT = markdown
HEADER = src/report/header.tex

.PHONY: all clean report.tex pdf

all: $(TARGET) pdf

$(TARGET): src/report/*.yaml src/report/*.md
	pandoc \
	-S \
	-H $(HEADER) \
	-f $(IN_FORMAT) \
	-t $(OUT_FORMAT) \
	-s -o $(TARGET) $^ \
	--top-level-division=chapter \
	--number-sections \
	--latex-engine=xelatex \
	--latex-engine-opt=-shell-escape

pdf:
	xelatex -shell-escape report.tex

clean:
	-@rm -f $(TARGET) report*
