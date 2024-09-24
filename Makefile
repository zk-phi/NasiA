# ---- HINTER
HINTER = ttfautohint --no-info # Use ttfautohint (fast fuzzy hinting, requires an external tool)
# HINTER = fontforge ./scripts/Autohint.pe # Use fontforge (sharp hinting)
# HINTER = cp # Skip hinting

# ---- OPTIONS
IAWRITEROPTS =
NASUMOPTS    =
MERGEOPTS    = --visiblespace

# ---- OUTPUT FILENAMES
SOURCE_IAWRITER = ./fonts/iAWriterMonoS-Regular.ttf
SOURCE_NASUM    = ./fonts/NasuM-Regular-20200227.ttf
TMP_IAWRITER    = ./tmp/iAWriterMonoS-Regular_adjusted.ttf
TMP_NASUM       = ./tmp/NasuM-Regular-20200227_adjusted.ttf
UNHINTED_OUTPUT = ./tmp/nasia-Medium_unhinted.ttf
HINTED_OUTPUT   = ./dist/nasia-Medium.ttf

all: $(HINTED_OUTPUT)
unhinted: $(UNHINTED_OUTPUT)
iawriter: $(TMP_IAWRITER)
nasum: $(TMP_NASUM)

$(HINTED_OUTPUT): $(UNHINTED_OUTPUT)
	$(HINTER) $(UNHINTED_OUTPUT) $(HINTED_OUTPUT)

$(UNHINTED_OUTPUT): ./scripts/nasia.pe $(TMP_IAWRITER) $(TMP_NASUM)
	fontforge ./scripts/nasia.pe $(MERGEOPTS) $(TMP_IAWRITER) $(TMP_NASUM) $(UNHINTED_OUTPUT)

$(TMP_IAWRITER): ./scripts/iAWriter.pe $(SOURCE_IAWRITER)
	fontforge ./scripts/iAWriter.pe $(IAWRITEROPTS) $(SOURCE_IAWRITER) $(TMP_IAWRITER)

$(TMP_NASUM): ./scripts/NasuM.pe $(SOURCE_NASUM)
	fontforge ./scripts/NasuM.pe $(NASUMOPTS) $(SOURCE_NASUM) $(TMP_NASUM)

clean:
	rm ./tmp/*.ttf
	rm ./dist/*.ttf
