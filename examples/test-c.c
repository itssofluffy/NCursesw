#include <unistd.h>
#include <ncurses.h>
#include <wchar.h>

int main() {
    WINDOW *wins = initscr();

    wborder_set(wins, WACS_VLINE, WACS_VLINE, WACS_HLINE, WACS_HLINE, WACS_ULCORNER, WACS_URCORNER, WACS_LLCORNER, WACS_LRCORNER);

    refresh();

    sleep(10);

    endwin();

    return 0;
}
