BUILD_DIR=build/linux
APP_NAME=AirRace
RAYLIB_PATH=ext/raylib-4.5.0_linux_amd64

SRCS = $(wildcard src/*.c)

build_linux: $(SRCS)

	if [ ! -d "build" ]; then mkdir build; fi
	if [ ! -d "build/linux" ]; then mkdir build/linux; fi

	cp -t build/linux $(RAYLIB_PATH)/lib/*.so*

	gcc -g \
	-Wall \
	-fdiagnostics-color=always \
	$(SRCS) \
	-o $(BUILD_DIR)/$(APP_NAME) \
	-I $(RAYLIB_PATH)/include \
	-L $(RAYLIB_PATH)/lib \
	-lraylib \
	-Wl,-rpath,'$$ORIGIN'

clean:
	rm -r build

run:
	./build/linux/AirRace