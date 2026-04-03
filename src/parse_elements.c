#include "../include/cubrun.h"

static char	*get_value(char *line)
{
	int	i;

	i = 0;
	while (line[i] && line[i] != ' ')
		i++;
	while (line[i] == ' ')
		i++;
	return (ft_strdup(line + i));
}

static void	parse_color(char *line, t_color *color)
{
	char	*val;
	char	**rgb;

	val = get_value(line);
	rgb = ft_split(val, ',');
	free(val);
	color->r = ft_atoi(rgb[0]);
	color->g = ft_atoi(rgb[1]);
	color->b = ft_atoi(rgb[2]);
	free_tab(rgb);
}

void	parse_element(char *line, t_scene *scene)
{
	if (ft_strncmp(line, "NO ", 3) == 0)
		scene->tex.no = get_value(line);
	else if (ft_strncmp(line, "SO ", 3) == 0)
		scene->tex.so = get_value(line);
	else if (ft_strncmp(line, "WE ", 3) == 0)
		scene->tex.we = get_value(line);
	else if (ft_strncmp(line, "EA ", 3) == 0)
		scene->tex.ea = get_value(line);
	else if (ft_strncmp(line, "F ", 2) == 0)
		parse_color(line, &scene->floor);
	else if (ft_strncmp(line, "C ", 2) == 0)
		parse_color(line, &scene->ceiling);
}
