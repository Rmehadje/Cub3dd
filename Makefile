NAME = cub3D

CFLAGS = -Wextra -Wall -Werror -g -O3

CC = gcc

LIB = lib

OBJ_DIR = obj/

SRC_DIR = src/

LIBMLX := ./lib/MLX42

HEADERS := -I ./include -I $(LIBMLX)/include

SRC := window.c settings.c raycast.c more_raycast.c main.c init.c move_camera.c parsing.c parsing2.c utils.c parsing3.c parsing4.c

OBJ = $(SRC:.c=.o)

SRCS = $(addprefix $(SRC_DIR), $(SRC))

OBJS = $(addprefix $(OBJ_DIR), $(OBJ))

LIBS = $(LIBMLX)/build/libmlx42.a

LDFLAGS := -ldl -lglfw -pthread -lm -flto -framework Cocoa -framework OpenGL -framework IOKit

LBFT = ./libft/libft.a


all: $(OBJ_DIR) $(NAME)

$(OBJ_DIR)%.o: $(SRC_DIR)%.c
	@$(CC) -c $< -o $@ $(CFLAGS) $(HEADER)

$(OBJ_DIR):
	@mkdir -p $(OBJ_DIR)
	@cd libft && make
	@mkdir lib && cd lib && git clone https://github.com/codam-coding-college/MLX42.git
	@cd lib/MLX42 && cmake -B build && cmake --build build -j4
	@clear


$(NAME): $(OBJS)
	@echo "Building..."
	@$(CC) $(CFLAGS) $(OBJS) $(LBFT) $(LIBS) $(HEADERS) $(LDFLAGS) -o $(NAME)


clean:
	@rm -rf lib/
	@cd libft && make clean
	@rm -rf $(OBJS)

fclean: clean
	cd libft && make fclean
	rm -f $(OBJ) $(NAME)
	rm -rf obj

re: fclean all

.PHONY: all clean fclean re