# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: wprintes <wprintes@student.42sp.org.br>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/10/01 09:30:09 by wprintes          #+#    #+#              #
#    Updated: 2023/11/12 15:17:59 by wprintes         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#GENERAL OPTIONS
# C Compiler
CC        :=    c++
# Compiler flags
CFLAGS    :=    -Wall -Wextra -Werror -std=c++98
# Removal tool
RM        :=    rm -rf

# PROGRAM
# Program name
NAME        :=	 ft_irc

# Headers
HEADER_DIR		:=    .
HEADER			:=    
H_INCLUDE		:=    $(addprefix -I, $(HEADER_DIR))

# Source
SRC_DIR        :=    .
SRC            :=    main.cpp 

# Object
OBJ_DIR        :=    obj
OBJ            :=    $(SRC:%.cpp=$(OBJ_DIR)/%.o)

# Inclusions:
INCLUDE        :=    $(H_INCLUDE)

# Development flag: set dev=1 to automatically find .cpp's and .hpp's
ifeq ($(dev), 1)
CFLAGS        +=    -g -fsanitize=address -fno-omit-frame-pointer
SRC            :=     $(shell find . -name '*.cpp' -type f)
SRC_DIR        :=    $(dir $(SRC))
SRC            :=    $(notdir $(SRC))
OBJ            :=    $(SRC:%.cpp=$(OBJ_DIR)/%.o)
HEADER        :=    $(shell find . -name '*.hpp' -type f)
H_INCLUDE    :=    $(sort $(addprefix -I, $(dir $(HEADER))))
INCLUDE        :=    $(H_INCLUDE)
endif

# vpath
vpath    %.hpp    $(HEADER_DIR)
vpath    %.cpp    $(SRC_DIR)


# -----------------------RULES------------------------------------------------ #
.PHONY: all vg clean fclean re

# Creates NAME
all: $(NAME)

# Compiles OBJ and LIBFT into the program NAME
$(NAME): $(OBJ)
	$(CC) $(CFLAGS) -o $@ $(OBJ) $(INCLUDE)

# Compiles SRC into OBJ
$(OBJ): $(OBJ_DIR)/%.o: %.cpp $(HEADER) | $(OBJ_DIR)
	$(CC) $(CFLAGS) -o $@ -c $< $(INCLUDE)

# Directory making
$(OBJ_DIR):
	@mkdir -p $@

client: 
	$(CC) $(CFLAGS) -o client ./client.cpp $(INCLUDE)

# Run program using valgrind
vg:
	valgrind --leak-check=full --show-leak-kinds=all ./$(NAME) test "bom dia" "42"

# Clean: removes objects' directory
clean:
	$(RM) $(OBJ_DIR) *.replace

# Full clean: removes objects' directory and generated programs
fclean: clean
	$(RM) $(NAME)

# Remake: full cleans and runs 'all' rule
re: fclean all