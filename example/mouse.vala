// valac --vapidir=./ libsuinput.vapi --pkg linux --pkg posix -X -lsuinput example/mouse.vala
using SimpleUserspaceInput;
using Linux.UserspaceInput;
using Linux.Input;
using Posix;

int main() {
        int fd;
        int[] btns = {BTN_LEFT, BTN_RIGHT, BTN_MIDDLE};
        int[] rel_axes = {REL_X, REL_Y, REL_WHEEL};
        int i;
        UserDevice uidev = UserDevice();

        uidev.name = (char[]) "libsuinput-example-mouse";

        fd = SimpleUserspaceInput.open();

        if (fd == -1)
                error("suinput_open");

        /* Error handling is omitted to keep code as readible as possible. */
        for (i = 0; i < 3; ++i) {
                enable_event(fd, (uint16) EV_KEY, (uint16) btns[i]);
        }

        for (i = 0; i < 3; ++i) {
                enable_event(fd, (uint16) EV_REL, (uint16) rel_axes[i]);
        }

        create(fd, &uidev);

        /* Move pointer 20 * 5 units towards bottom-right. */
        for (i = 0; i < 20; ++i) {
                emit(fd, (uint16) EV_REL, (uint16) REL_X, 5);
                emit(fd, (uint16) EV_REL, (uint16) REL_Y, 5);
                syn(fd);
                sleep(5);
        }

        emit(fd, EV_KEY, (uint16) BTN_LEFT, 1); /* Press. */
        syn(fd); /* "Flushes" events written so far. */

        emit(fd, EV_KEY, (uint16) BTN_LEFT, 0); /* Release. */
        syn(fd);

        destroy(fd);

        return 0;
}