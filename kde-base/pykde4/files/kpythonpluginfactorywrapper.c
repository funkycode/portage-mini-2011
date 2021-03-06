#include <dlfcn.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define VERSION_LEN 10

#define FORMAT EPREFIX PLUGIN_DIR "/kpython%spluginfactory.so"

static void *handle;
static void *(*wrapped_qt_plugin_instance)();

static void get_python_version(char* out) {
	int pipefd[2];
	pipe(pipefd);
	pid_t cpid = fork();
	if (cpid == 0) {
		close(pipefd[1]);
		read(pipefd[0], out, VERSION_LEN);
	} else {
		close(pipefd[0]);
		close(1);
		dup2(pipefd[1], 1);
		close(pipefd[1]);
		close(0);
		char *args[] = { "eselect", "python", "show", "--ABI", "--python2", 0 };
		execv(EPREFIX "/usr/bin/eselect", args);
	}
}

__attribute__((constructor))
static void init() {
	char buf[VERSION_LEN + 1];
	memset(buf, 0, VERSION_LEN + 1);
	get_python_version(buf);
	int length = strlen(FORMAT) + strlen(buf) + 1;
	char *name = malloc(length + 1);
	snprintf(name, length, FORMAT, buf);
	void *handle = dlopen(name, RTLD_NOW);
	free(name);
	wrapped_qt_plugin_instance = dlsym(handle, "qt_plugin_instance");
}

__attribute__((destructor))
static void fini() {
	dlclose(handle);
}

void *qt_plugin_instance() {
	return wrapped_qt_plugin_instance();
}
