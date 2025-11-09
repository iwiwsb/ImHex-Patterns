#pragma array_limit 99999999
#pragma pattern_limit 99999999
#pragma magic [ 50 4D 4C 5F ] @ 0x00

struct OSVERSIONINFOEXW {
    u32    dwOSVersionInfoSize;
    u32    dwMajorVersion;
    u32    dwMinorVersion;
    u32    dwBuildNumber;
    u32    dwPlatformId;
    char16 szCSDVersion[128];
    u16    wServicePackMajor;
    u16    wServicePackMinor;
    u16    wSuiteMask;
    u8     wProductType;
    u8     wReserved;
};

struct String {
    u32 size;
    char16 string[size/2];
};

struct StringsArray {
    u32 num_of_strings;
    u32 relative_offsets[num_of_strings];
    String strings[num_of_strings]; 
};

struct Module {
    u32 unknown;
    u64 base_address;
    u32 size_of_module;
    u32 image_path_str_index;
    u32 version_str_index;
    u32 company_str_index;
    u32 description_str_index;
    u32 timestamp;
};

struct Process {
    u32 index;
    u32 pid;
    u32 parent_pid;
    u64 auth_id;
    u32 session_number;
    u32 unknown;
    u64 start_time;
    u64 end_time;
    u32 is_virtualized;
    u32 is_64_bit;
    u32 integrity;
    u32 user_str_index;
    u32 process_name_str_index;
    u32 image_path_str_index;
    u32 cmdline_str_index;
    u32 company_str_index;
    u32 version_str_index;
    u32 description_str_index;
    u32 small_icon_index;
    u32 large_icon_index;
    u32 reserved;
    u32 num_of_modules;
    Module modules[num_of_modules];
};

struct ProcessesArray {
    u32 number_of_elements;
    u32 indexes_array[number_of_elements];
    u32 relative_offsets[number_of_elements];
    //Process processes[number_of_elements];
};

struct Host {
    u8 ip[16];
    String host;
};

struct Port {
    u16 port_number;
    u16 is_tcp;
    String port_name;
};

struct HostsAndPortsArray {
    u32 num_of_hosts;
    Host hosts[num_of_hosts];
    u32 num_of_ports;
    Port ports[num_of_ports];
};

struct Event {
    u32 process_idx;
    u32 thread_id;
    u32 event_class;
    u16 operation;
    u8 reserved[6];
    u64 duration;
    be u64 time_captured;
    u32 result;
    u16 stack_trace_depth;
    u16 reserved_2;
    u32 detail_size;
    u32 extra_detail_offset;
};

char                magic[4]                       @ 0x0000;
u32                 version                        @ 0x0004;
u32                 bitness                        @ 0x0008;
char16              computer_name[16]              @ 0x000C;
char16              system_root[260]               @ 0x002C;
u32                 total_num_of_events            @ 0x0234;
u8                  unknown[8]                     @ 0x0238;
u64                 events_array_offset            @ 0x0240;
u64                 offsets_to_events_array_offset @ 0x0248;
ProcessesArray*     processes_array_offset : u64   @ 0x0250;
StringsArray*       strings_array_offset : u64     @ 0x0258;
u64                 icons_array_offset             @ 0x0260;
u64                 max_app_address                @ 0x0268;
OSVERSIONINFOEXW    os_version_info_ex_w           @ 0x0270;
u32                 num_of_processors              @ 0x038C;
u64                 total_physical_mem_in_bytes    @ 0x0390;
u64                 events_array_offset2           @ 0x0398;
HostsAndPortsArray* hosts_and_ports_array : u64    @ 0x03A0;
