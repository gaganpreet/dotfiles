import rlcompleter
import readline
import os
import atexit

hist_file = os.path.expanduser("~/.py_history")

# Load history into memory
if os.path.exists(hist_file):
    readline.read_history_file(hist_file)

def save_history(hist_file=hist_file):
    readline.write_history_file(hist_file)
atexit.register(save_history)


readline.parse_and_bind("tab: complete")
