#include "../include/cubrun.h"

static int	get_max_width(char **lines, int start, int height)
{
	int	i;
	int	max;
	int	len;

	i = 0;
	max = 0;
	while (i < height)
	{
		len = ft_strlen(lines[start + i]);
		if (len > max)
			max = len;
		i++;
	}
	return (max);
}

static void	fill_map(char **lines, int start, int height, t_map *map)
{
	int	i;

	i = 0;
	while (i < height)
	{
		map->grid[i] = ft_strdup(lines[start + i]);
		i++;
	}
}

void	parse_map(char **lines, int start, t_scene *scene)
{
	int	height;

	height = size_tab(lines) - start;
	scene->map.height = height;
	scene->map.width = get_max_width(lines, start, height);
	scene->map.grid = ft_calloc(height + 1, sizeof(char *));
	fill_map(lines, start, height, &scene->map);
}
