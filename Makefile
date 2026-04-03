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

.PHONY: all clean fclean re