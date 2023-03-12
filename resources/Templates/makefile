MKDIR  = mkdir -p
REMOVE = rm -rf

CC     = clang
CFLAGS = -std=c2x -g -Wall -Wextra -Wpedantic -Wfloat-equal -Wformat
AR      = ar
ARFLAGS = -cvrs

PROJECT_NAME = template
EXEC         = $(PROJECT_NAME)
# LIBRARY    = lib$(PROJECT_NAME).a

# -- Project Paths -- #
PROJECT_DIR = $(CURDIR)
INCLUDE_DIR = $(PROJECT_DIR)/include
SOURCES_DIR = $(PROJECT_DIR)/src
BUILD_DIR   = $(PROJECT_DIR)/build
TESTS_DIR   = $(PROJECT_DIR)/tests

OBJ_DIR     = $(BUILD_DIR)/objs

EXEC_PATH   = $(BUILD_DIR)/$(EXEC)
# LIBRARY_PATH = $(BUILD_DIR)/$(LIBRARY)

# -- Project Sources -- #
PROJECT_SOURCES = $(wildcard $(SOURCES_DIR)/*.c)
PROJECT_HEADERS = $(wildcard $(INCLUDE_DIR)/**/*.h)
PROJECT_OBJS    = $(patsubst $(SOURCES_DIR)/%.c, $(OBJ_DIR)/%.o, $(SOURCES))

# -- Testing -- #
TESTS_BIN_DIR = $(BUILD_DIR)/tests
TESTS_SOURCES = $(wildcard $(TESTS_DIR)/*.c)
TESTS_BINS    = $(patsubst $(TESTS_DIR)/%.c, $(TESTS_BIN_DIR)/%, $(TESTS_SOURCES))

FTMT   = clang-format
FFLAGS = -i


default: all
# all: $(LIBRARY)
all: $(EXEC)

release: CFLAGS=-Wall -Werror -O3 -DNDEBUG
release: clean
release: $(LIBRARY)

# $(LIBRARY): $(BUILD_DIR) $(OBJ_DIR) $(OBJS)
# 	$(RM) $(LIBRARY)
# 	$(AR) $(ARFLAGS) $(LIBRARY) $(OBJS)

$(EXEC_PATH): $(BUILD_DIR) $(OBJ_DIR) $(PROJECT_OBJS)
	$(RM) $(EXEC_PATH)
	$(CC) $(CFLAGS) $(PROJECT_OBJS) -o $@

$(BUILD_DIR):
	$(MKDIR) $@

$(OBJ_DIR):
	$(MKDIR) $@

$(OBJ_DIR)/%.o: $(SOURCES_DIR)/%.c $(INCLUDE_DIR)/$(PROJECT_NAME)/%.h
	$(CC) $(CFLAGS) -c $< -o $@ -I$(INCLUDE_DIR)

$(OBJ_DIR)/%.o: $(SOURCES_DIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@ -I$(INCLUDE_DIR)


tests: $(PROJECT_OBJS) $(TESTS_BIN_DIR) $(TESTS_BINS)
	@for test in $(TESTS_BINS); do $$test ; done

$(TESTS_BIN_DIR)/%: $(TESTS_DIR)/%.c
	$(CC) $(CFLAGS) $< $(OBJS) -o $@ -lcriterion -I$(INCLUDE_DIR)

$(TESTS_BIN_DIR):
	$(MKDIR) $@


clean, veryclean:
	$(REMOVE) $(BUILD_DIR)

# --- Formating --- #
format: format-source format-tests

format-source:
	$(FORMATTER) $(FORMATTER_FLAGS) $(SOURCES)
	$(FORMATTER) $(FORMATTER_FLAGS) $(HEADERS)

format-tests:
	$(FORMATTER) $(FORMATTER_FLAGS) $(TESTS_SOURCES)

.PHONY: default, all, main, clean, veryclean, format, format-source, format-tests

