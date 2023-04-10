APP_NAME=AirRace

SRCS = $(wildcard src/*.c*)

build: $(SRCS)
# Create build folder
	if [ ! -d "build" ]; then mkdir build; fi
# Copy shared libraries to build
	cp -t build lib/*.so*

	gcc -g \
	-Wall \
	-fdiagnostics-color=always \
	$(SRCS) \
	-o build/$(APP_NAME) \
	-I src \
	-L lib \
	-lraylib \
	-lm \
	-Wl,-rpath,'$$ORIGIN'

clean:
	rm -r build

run:
	./build/$(APP_NAME)