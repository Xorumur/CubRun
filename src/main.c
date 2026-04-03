#include "../include/cubrun.h"

int	main(int ac, char **av)
{
	t_scene	*scene;
	int		i;

	if (ac != 2)
		return (1);
	scene = parse_scene(av[1]);
	ft_printf("NO: %s\n", scene->tex.no);
	ft_printf("SO: %s\n", scene->tex.so);
	ft_printf("WE: %s\n", scene->tex.we);
	ft_printf("EA: %s\n", scene->tex.ea);
	ft_printf("Floor  : %d,%d,%d\n", scene->floor.r, scene->floor.g, scene->floor.b);
	ft_printf("Ceiling: %d,%d,%d\n", scene->ceiling.r, scene->ceiling.g, scene->ceiling.b);
	ft_printf("Map %dx%d:\n", scene->map.width, scene->map.height);
	i = 0;
	while (i < scene->map.height)
		ft_printf("  [%s]\n", scene->map.grid[i++]);
	return (0);
}
