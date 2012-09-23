OBJC = clang
PList = Info.plist
OBJCFlags = -O2 -Weverything -Wno-unused-parameter
LDFlags = -sectcreate __TEXT __info_plist $(PList) -framework Foundation

AllTargets = $(basename $(wildcard src/*.m))

all: notify

notify: $(addsuffix .o,$(AllTargets))
	$(OBJC) $(LDFlags) -o $@ $^

%.o: %.m
	$(OBJC) $(OBJCFlags) -c -o $@ $<

%.o: %.m %.h
	$(OBJC) $(OBJCFlags) -c -o $@ $<

clean:
	rm -fv src/*.o
