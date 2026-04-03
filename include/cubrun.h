#ifndef CUBRUN_H
# define CUBRUN_H

# include "../lib/libft/libft.h"
# include "../lib/ft_printf/ft_printf.h"
# include "../lib/minilibx-linux/mlx.h"
# include <fcntl.h>

typedef struct s_color
{
	int	r;
	int	g;
	int	b;
}	t_color;

typedef struct s_textures
{
	char	*no;
	char	*so;
	char	*we;
	char	*ea;
}	t_textures;

typedef struct s_map
{
	char	**grid;
	int		width;
	int		height;
}	t_map;

typedef struct s_scene
{
	t_textures	tex;
	t_color		floor;
	t_color		ceiling;
	t_map		map;
}	t_scene;

t_scene	*parse_scene(char *path);
void	parse_element(char *line, t_scene *scene);
void	parse_map(char **lines, int start, t_scene *scene);

#endif
