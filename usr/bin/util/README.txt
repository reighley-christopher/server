this is a set of command line tools intended to simplify and automate
analytics processes.

rules of etiquette :
a amqp queue may already be declared with different defaults than you would like.
too bad, check for it and do not fail unless you absolutely have to.

an amqp queue might delete itself if there are no messages.  Were you
listening?  Too bad!  You may have to declare the queue again.

avoid opening a file unless disk is your job.  Data comes from stdin and goes
to stdout or travels by rabbit queues.  Same is true for http requests, only
play with socketss if sockets are your job.  The exception is configuration 
information you need to start up, library paths, jar files etc.

arff_string_to_word_vector:


arff_to_weka_json:
fake_piped:

filter_lines:
randomly cuts down the size of its input
example (cuts out half the lines)
filter_lines 0.5

json_by_python_transform:

rabbitmq_to_chimp_feature:
loads a set of riskychimp features and annotates incoming data with them.
message queue to message queue
usage:
rabbitmq_to_chimp_feature inqueue outqueue feature_dir
inqueu is the name of the queue of incoming records
outqueue is the name of the queue of annotated records
feature_dir is the directory which I search for chimp features when starting
up 

rabbitmq_input_socket:
creates a unix domain socket to a rabbitmq message queue.
usage:
rabbitmq_input_socket parser path queue
parse is "Newline" or "JSON"
path is the location to create the socket
queue is the name of the message queue

rabbitmq_to_repo_process:

rabbitmq_to_stdout:
pulls data off of a rabbitmq message queue and dumps it to standard out.

readmefy_a_list:

strip_http_envelope:

strip_newline:

unpack_json_array:
strips off the [] and , in a JSON array on STDIN and sends a sequence of documents to STDOUT

weka_json_to_mahout_kmean:

