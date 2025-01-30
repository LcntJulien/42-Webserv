# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jlecorne <jlecorne@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/01/30 17:01:56 by jlecorne          #+#    #+#              #
#    Updated: 2025/01/30 17:01:57 by jlecorne         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

GRAY 		= \033[90m
GREEN   	= \033[32m
RED			= \033[31m
MAGENTA 	= \033[35m
YELLOW  	= \033[33m
BLUE		= \033[34m
BOLD		= \033[1m
RESET   	= \033[0m

NAME		= webserv

CXX			= c++
CXXFLAGS	= -Wall -Wextra -Werror -std=c++98
SRCDIR		= srcs
SRC 		= $(wildcard $(SRCDIR)/*.cpp) $(wildcard $(SRCDIR)/*/*.cpp)
# SRC			= $(shell find $(SRCDIR) -name '*.cpp')
OBJDIR		= .obj
OBJ 		= $(patsubst $(SRCDIR)/%.cpp, $(OBJDIR)/%.o, $(SRC))
HEADER		= -I include

all: $(NAME)

# Linking des objets
$(NAME): $(OBJ)
	@printf "$(GRAY) - $(NAME)$(RESET)\t"
	@$(CXX) $(CXXFLAGS) $(HEADER) $(OBJ) -o $(NAME)
	@printf "$(GREEN)[OK]$(RESET)\n"

# Compilation des sources et gestion de fichiers d'objets
$(OBJDIR)/%.o: $(SRCDIR)/%.cpp
	@mkdir -p $(dir $@)
	@$(CXX) $(CXXFLAGS) -c $< -o $@

# Suppression objets
clean:
	@if [ -d "$(OBJDIR)" ]; then \
		printf "$(GRAY) - $(NAME)$(RESET)\t"; \
		rm -rf $(OBJDIR); \
		printf "$(BLUE)[OBJECTS REMOVED]$(RESET)\n"; \
	else \
		printf "$(GRAY) - $(NAME)$(RESET)\t$(YELLOW)[NO OBJECTS FOUND]$(RESET)\n"; \
	fi

# Suppression programme
fclean: clean
	@if [ -e "$(NAME)" ]; then \
		printf "$(GRAY) - $(NAME)$(RESET)\t"; \
		rm -f $(NAME); \
		printf "$(BLUE)[PROGRAM REMOVED]$(RESET)\n"; \
	else \
		printf "$(GRAY) - $(NAME)$(RESET)\t$(YELLOW)[NO FILE FOUND]$(RESET)\n"; \
	fi

re: fclean all

# Linking debug
debug: $(OBJ)
	@printf "$(GRAY) - $(NAME)$(RESET)\t"
	@$(CXX) -g3 $(CXXFLAGS) $(HEADER) $(OBJ) -o $(NAME) -fsanitize=address
	@printf "$(BOLD)$(MAGENTA)[DEBUG]$(RESET)\n"

.PHONY: all, clean, fclean, re, debug