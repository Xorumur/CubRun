# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mlecherb <mlecherb@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/10/27 14:33:47 by mlecherb          #+#    #+#              #
#    Updated: 2021/10/27 16:38:14 by mlecherb         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME		= gnl.a

OBJ			= $(SRCS:.c=.o)

CFLAGS		= -Wall -Wextra -Werror

SRCS =	get_next_line.c get_next_line_utils.c 

LIB = get_next_line.h

$(NAME):	$(OBJ)
			ar rcs $(NAME) $(OBJ)

all:		$(NAME)

clean:
			rm -f $(OBJ) 

fclean: 	clean
			rm -f $(NAME)

norme:
			norminette -R CheckForbiddenSourceHeader $(SRCS) ${LIB}

re:			fclean all

.PHONY :	all clean fclean re
