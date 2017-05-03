from yajl_bindings import *
from io import StringIO

class JsonStream(object):
    def __init__(self):
        self.parser = yajl.yajl_alloc(None, None, None)
        self.buf = StringIO()
        self.read_ptr = 0
        self.consume_ptr = 0

    def write(self, string):
        self.buf.seek(len(self.buf.getvalue()))
        self.buf.write(unicode(string))

    def read(self):
        pending_len = self.read_ptr - self.consume_ptr
        self.buf.seek(self.read_ptr)
        string = self.buf.read()
        self.read_ptr = self.read_ptr + len(string)
        status = yajl.yajl_parse(self.parser, string, len(string))
        state = yajl_current_state(self.parser)
        consumed = yajl.yajl_get_bytes_consumed(self.parser)

        #document incomplete, do nothing
        if ( (status == 0 and state != 1) ) :
            return None

        self.buf.seek(self.consume_ptr)

        #error case, push it off the end, back out the error character
        if (status == 2) :
            print( yajl_states[state] )
            output = self.buf.read(pending_len + consumed - 1)
            #empty string is a valid json document but it isn't actually what we want.
            if(output == "") :
                output = self.buf.read(1)

        #clean read, the end of the buffer was at the end of a valid document
        if (status == 0 and state == 1) :
            output = self.buf.read()

        self.consume_ptr = self.consume_ptr + len(output)
        self.read_ptr = self.consume_ptr
        yajl_state_reset(self.parser)
        return str(output)

    def __del__(self):
        yajl.yajl_free(self.parser)
