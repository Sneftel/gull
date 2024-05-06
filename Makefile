
BOARDS = centerboard fingerboard thumbboard
SUBDIRS = $(BOARDS) frame

.PHONY: clean all $(SUBDIRS)

all: $(SUBDIRS)

centerboard:
	$(MAKE) -C centerboard

fingerboard:
	$(MAKE) -C fingerboard

thumbboard:	
	$(MAKE) -C thumbboard

frame:
	$(MAKE) -C frame

clean:
	for subdir in $(SUBDIRS) ; do \
		$(MAKE) -C $$subdir clean ; \
	done
