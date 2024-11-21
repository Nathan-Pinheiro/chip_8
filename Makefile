# / Windows MakeFile /

COMPILER = gcc
COMPILER_FLAGS = -I include
LIBRARIES = -L lib -lmingw32 -lSDL2main -lSDL2

SOURCE_FILES_LIST = ""
OBJECT_FILE_LIST =  $(addprefix build/, $(notdir $(SOURCE_FILES_LIST:.c=.o)))

# function to find a source file given the object file associated
find_source = $(shell powershell -Command "$$first_list = '$(OBJECT_FILE_LIST)'; $$second_list = '$(SOURCE_FILES_LIST)'; $$SEARCH_WORD = '$(1)'; $$words_1 = $$first_list -split ' '; $$words_2 = $$second_list -split ' '; $$index = [Array]::IndexOf($$words_1, $$SEARCH_WORD); if ($$index -ge 0) { $$result = $$words_2[$$index]; Write-Output $$result } else { Write-Output 'Not found' }")

all : bin/main

bin/main: $(OBJECT_FILE_LIST)
	$(COMPILER) src/main.c $^ -o bin/main $(COMPILER_FLAGS) $(LIBRARIES)

build/%.o:
	$(COMPILER) $(COMPILER_FLAGS) -c $(call find_source,$@) -o $@

clean: 
	del /Q /F build\*.o bin\main.exe
.PHONY: clean