using Linux.UserspaceInput;
using Linux.Input;

[CCode (cprefix="suinput_", cheader_filename="suinput.h")]
namespace SimpleUserspaceInput {

	[CCode (cname = "suinput_open")]
	int open();

	[CCode (cname = "suinput_enable_event")]
	int enable_event(int uinput_fd, uint16 ev_type, uint16 ev_code);

	[CCode (cname = "suinput_create")]
	int create(int uinput_fd, UserDevice *user_dev_p);

	[CCode (cname = "suinput_write_event")]
	int write_event(int uinput_fd, Event *event_p);

	[CCode (cname = "suinput_emit")]
	int emit(int uinput_fd, uint16 ev_type, uint16 ev_code,
	                 int32 ev_value);

	[CCode (cname = "suinput_syn")]
	int syn(int uinput_fd);

	[CCode (cname = "suinput_destroy")]
	int destroy(int uinput_fd);
}