short = scipy-2018
deck = scipy-arcgis
event = devsummit-2018
theme = esri-dev-summit-2018
upload_loc = 4326.us:esri/$(short)
public_loc = https://4326.us/esri/$(short)
slide_dir = $(shell pwd)

all:
	pandoc -t revealjs -s slides.md -V controls=false -V progress=true -V history=true -V center=true -V transition=slide -V theme=$(theme) --css src/$(event).css --template=src/$(event).revealjs --highlight-style=zenburn --slide-level 2 -o index.html

check:
	linkchecker --check-extern index.html

pdf:
	pandoc -o $(event)-$(deck)-presentation-handout.pdf -V fontsize=12pt -V mainfont=Helvetica --latex-engine=xelatex slides.md

fullpdf:
# decktape can't scrape HTTPS URIs with a relative path, swich directories.
# Also scrape very slowly -- want backgrounds rendered.
	cd ~/devsummit/decktape && bin/phantomjs decktape.js --pause=4000 --url=$(public_loc) --filename=$(slide_dir)/$(event)-$(deck)-presentation-full.pdf

clean:
	rm index.html $(event)-$(deck)-presentation-handout.pdf $(event)-$(deck)-presentation-full.pdf

upload:
	cp -Rvp ../../repo/mkl-perf . && cp mkl-perf/mkl-perf.html mkl-perf/index.html && rsync --partial --progress -r . 4326.us:esri/$(short) && open $(public_loc)
