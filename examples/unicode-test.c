#define _XOPEN_SOURCE_EXTENDED 1

#include <locale.h>
#include <unistd.h>
#include <wchar.h>
#include <string.h>

#include <ncurses.h>

int main (int argc, char *argv[]) {
    setlocale(LC_ALL, "");

    const wchar_t *wch = L"\u250c\u2514\u2510\u2518\u2500\u2502";
    cchar_t wcval[6];

    for (int i = 0 ; wch[i] != 0 ; i++) {
	wchar_t w[CCHARW_MAX];
	memset(w, 0x00, CCHARW_MAX);

	w[0] = wch[i];

	setcchar(&wcval[i], w, A_NORMAL, 0, NULL);
    }

    WINDOW *win = initscr();

    wborder_set(win, &wcval[5], &wcval[5], &wcval[4], &wcval[4], &wcval[0], &wcval[2], &wcval[1], &wcval[3]);

    mvwaddwstr(win, 1, 1, wch);

    getch();

    endwin();

    return 0;
}
