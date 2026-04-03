NAME = cubrun

CC = cc
CFLAGS = -Wall -Wextra -Werror

SRC_DIR = src
OBJ_DIR = obj
SRC = $(wildcard $() $(SRC_DIR)/*.c)
OBJ = $(SRC:$(SRC_DIR)/%.c=$(OBJ_DIR)/%.o)

# Includes
INCLUDES = -Iinclude -Ilib/ft_printf -Ilib/libft

# Libs paths
LIB_PATH = lib

FT_PRINTF_DIR = $(LIB_PATH)/ft_printf
FT_PRINTF_LIB = $(FT_PRINTF_DIR)/libftprintf.a

LIBFT_DIR = $(LIB_PATH)/libft
LIBFT_LIB = $(LIBFT_DIR)/libft.a

MLX_DIR = $(LIB_PATH)/minilibx-linux
MLX_LIB = $(LIB_PATH)/minilibx-linux/libmlx.a

GNL_DIR = $(LIB_PATH)/get_next_line
GNL_LIB = $(LIB_PATH)/get_next_line/gnl.a


# Libs (ordre: objets puis libs)
LIBS = $(FT_PRINTF_LIB) $(LIBFT_LIB) $(MLX_LIB) $(GNL_LIB)

all: $(LIBFT_LIB) $(FT_PRINTF_LIB) $(GNL_LIB) $(NAME)

$(NAME): $(OBJ)
	$(CC) $(CFLAGS) $(OBJ) $(LIBS) -o $(NAME)

$(FT_PRINTF_LIB):
	$(MAKE) -C $(FT_PRINTF_DIR)

$(LIBFT_LIB):
	$(MAKE) -C $(LIBFT_DIR)

$(MLX_LIB):
	$(MAKE) -C $(MLX_DIR)

$(GNL_LIB):
	$(MAKE) -C $(GNL_DIR)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

clean:
	rm -rf $(OBJ_DIR)
	$(MAKE) -C $(FT_PRINTF_DIR) clean
	$(MAKE) -C $(LIBFT_DIR) clean
	$(MAKE) -C $(GNL_DIR) clean

fclean: clean
	rm -f $(NAME)
	$(MAKE) -C $(FT_PRINTF_DIR) fclean
	$(MAKE) -C $(LIBFT_DIR) fclean
	$(MAKE) -C $(GNL_DIR) clean

re: fclean all

# Docker targets (required on Mac M1 — minilibx-linux needs a Linux x86_64 env)
# Prerequisites: Docker Desktop + XQuartz installed on macOS
# Before first run: open XQuartz > Preferences > Security > allow network connections
# Usage: make docker-run MAP=maps/my_map.cub

DOCKER_IMAGE = cubrun-dev
MAP ?= map.cub

docker-build:
	docker build --platform linux/amd64 -t $(DOCKER_IMAGE) .

docker-run: docker-build
	xhost +127.0.0.1
	docker run --rm \
		--platform linux/amd64 \
		-e DISPLAY=host.docker.internal:0 \
		-v $(shell pwd):/app \
		-w /app \
		$(DOCKER_IMAGE) \
		sh -c "make re && ./$(NAME) $(MAP)"

docker-shell: docker-build
	docker run --rm -it \
		--platform linux/amd64 \
		-e DISPLAY=host.docker.internal:0 \
		-v $(shell pwd):/app \
		-w /app \
		$(DOCKER_IMAGE) \
		bash

.PHONY: all clean fclean re docker-build docker-run docker-shell