# based on https://github.com/ShinKage/idris2-sdl/blob/master/sdl_glue/Makefile

IDRIS		:= idris2
MACHINE		:= $(shell $(CC) -dumpmachine)

ifneq (, $(findstring darwin, $(MACHINE)))
	OS	:= darwin
else ifneq (, $(findstring cygwin, $(MACHINE)))
	OS	:= windows
else ifneq (, $(findstring mingw, $(MACHINE)))
	OS	:= windows
else ifneq (, $(findstring windows, $(MACHINE)))
	OS	:= windows
else
	OS	:= unix
endif

ifeq ($(OS), darwin)
	SHLIB_SUFFIX	:= dylib
else ifeq ($(OS), windows)
	SHLIB_SUFFIX	:= dll
else
	SHLIB_SUFFIX	:= so
endif

LIBTARGET = utils.$(SHLIB_SUFFIX)
VERSION = 0.0.1
INSTALLDIR = `${IDRIS} --libdir`/DependentCAD-$(VERSION)

OBJS = utils.o

$(LIBTARGET): $(OBJS)
	$(CC) -o $@ -shared $<

clean:
	rm -f $(OBJS) $(LIBTARGET)

install:
	mkdir -p $(INSTALLDIR)/lib
	install -m 755 $(LIBTARGET) $(INSTALLDIR)/lib

.PHONY: install clean
