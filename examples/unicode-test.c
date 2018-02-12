#define _XOPEN_SOURCE_EXTENDED 1
#define CHAR_AS_HEX 0

#include <locale.h>
#include <unistd.h>
#include <wchar.h>
#include <string.h>

#include <ncurses.h>

int main (int argc, char *argv[]) {
    setlocale(LC_ALL, "");

    const wchar_t *wch = L"\u2502\u2502\u2500\u2500\u250c\u2510\u2514\u2518";
    cchar_t wcval[8];

    for (int i = 0 ; i < 8 ; i++) {
	wchar_t w[CCHARW_MAX];
	memset(w, 0x00, CCHARW_MAX);

	w[0] = wch[i];

	setcchar(&wcval[i], w, A_NORMAL, 0, NULL);

        printf("i=%d [attr=%d", i, wcval[i].attr);
        for (int x = 0 ; x < CCHARW_MAX ; x++) {
#if CHARS_AS_HEX
            printf(",chars[%d]=0x%x", x, wcval[i].chars[x]);
#else
            printf(",chars[%d]=%d", x, wcval[i].chars[x]);
#endif
        }
        printf(",ext_color=%d]\n", wcval[i].ext_color);
    }

    WINDOW *win = initscr();

    wborder_set(win, &wcval[0], &wcval[1], &wcval[2], &wcval[3], &wcval[4], &wcval[5], &wcval[6], &wcval[7]);

    mvwaddwstr(win, 1, 1, wch);

    getch();

    endwin();

    return 0;
}
