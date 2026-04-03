#include "../include/cubrun.h"

static char	*read_file(char *path)
{
	int		fd;
	char	buf[4096];
	char	*content;
	char	*tmp;
	int		n;

	fd = open(path, O_RDONLY);
	content = ft_strdup("");
	n = read(fd, buf, 4095);
	while (n > 0)
	{
		buf[n] = '\0';
		tmp = ft_strjoin(content, buf);
		free(content);
		content = tmp;
		n = read(fd, buf, 4095);
	}
	close(fd);
	return (content);
}

static int	is_identifier(char *line)
{
	return (ft_strncmp(line, "NO ", 3) == 0
		|| ft_strncmp(line, "SO ", 3) == 0
		|| ft_strncmp(line, "WE ", 3) == 0
		|| ft_strncmp(line, "EA ", 3) == 0
		|| ft_strncmp(line, "F ", 2) == 0
		|| ft_strncmp(line, "C ", 2) == 0);
}

static int	get_map_start(char **lines)
{
	int	i;

	i = 0;
	while (lines[i])
	{
		if (!is_identifier(lines[i]))
			return (i);
		i++;
	}
	return (i);
}

static void	parse_lines(char **lines, t_scene *scene)
{
	int	map_start;
	int	i;

	map_start = get_map_start(lines);
	i = 0;
	while (i < map_start)
	{
		parse_element(lines[i], scene);
		i++;
	}
	parse_map(lines, map_start, scene);
}

t_scene	*parse_scene(char *path)
{
	t_scene	*scene;
	char	*content;
	char	**lines;

	scene = ft_calloc(1, sizeof(t_scene));
	content = read_file(path);
	lines = ft_split(content, '\n');
	free(content);
	parse_lines(lines, scene);
	free_tab(lines);
	return (scene);
}
