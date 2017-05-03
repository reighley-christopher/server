import ctypes

yajl = ctypes.cdll.LoadLibrary("/usr/local/lib/libyajl.so")

class yajl_Bytestack(ctypes.Structure):
    _fields_ = [
            ("stack", ctypes.POINTER(ctypes.c_ubyte) ),
            ("size", ctypes.c_size_t),
            ("used", ctypes.c_size_t),
            ("yaf", ctypes.c_void_p)
            ]

class yajl_Handle(ctypes.Structure):
    _fields_ = [
            ("callbacks", ctypes.c_void_p),
            ("ctx", ctypes.c_void_p),
            ("lexer", ctypes.c_void_p),
            ("parseError", ctypes.c_char_p),
            ("bytesConsumed", ctypes.c_size_t),
            ("decodeBuf", ctypes.c_void_p),
            ("stateStack", yajl_Bytestack),
            ("alloc", ctypes.c_void_p),
            ("flags", ctypes.c_int)
            ]

yajl_states = [
    "yajl_state_start",
    "yajl_state_parse_complete",
    "yajl_state_parse_error",
    "yajl_state_lexical_error",
    "yajl_state_map_start",
    "yajl_state_map_sep",
    "yajl_state_map_need_val",
    "yajl_state_map_got_val",
    "yajl_state_map_need_key",
    "yajl_state_array_start",
    "yajl_state_array_got_val",
    "yajl_state_array_need_val",
    "yajl_state_got_value"
]

def yajl_current_state(handle):
    stack = handle.contents.stateStack
    return stack.stack[stack.used-1]

def yajl_state_reset(handl):
    stack = handl.contents.stateStack
    stack.stack[0] = 0
    stack.used = 1

yajl.yajl_alloc.restype = ctypes.POINTER(yajl_Handle)
yajl.yajl_alloc.argtypes = [ctypes.c_void_p, ctypes.c_void_p, ctypes.c_void_p]

yajl.yajl_config.restype = ctypes.c_int
yajl.yajl_config.argtypes = [ctypes.c_void_p, ctypes.c_int]

yajl.yajl_get_bytes_consumed.restype = ctypes.c_int
yajl.yajl_get_bytes_consumed.argtypes = [ctypes.c_void_p]

yajl.yajl_parse.restype = ctypes.c_int
yajl.yajl_parse.argtypes = [ctypes.c_void_p, ctypes.c_char_p, ctypes.c_size_t]

yajl.yajl_free.argtypes = [ctypes.c_void_p]

