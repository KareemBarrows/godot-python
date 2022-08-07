# Start with a sanity check to ensure the loading is done from Godot-Python
# (and not from a regular Python interpreter which would lead to a segfault).
# The idea is we should have the following loading order:
# godot binary -> libpythonscript.so -> _pythonscript.so -> godot/__init__.py
import sys

if "_pythonscript" not in sys.modules:
    raise ImportError(
        "Cannot initialize godot module given Godot GDNative API not available.\n"
        "This is most likely because you are running code from a regular Python interpreter"
        " (i.e. doing something like `python my_script.py`) while godot module is only available"
        " to Python code loaded from Godot through Godot-Python plugin."
    )
del sys

from godot._version import __version__

# from godot.tags import (
#     MethodRPCMode,
#     PropertyHint,
#     PropertyUsageFlag,
#     rpcdisabled,
#     rpcremote,
#     rpcmaster,
#     rpcpuppet,
#     rpcslave,
#     rpcremotesync,
#     rpcsync,
#     rpcmastersync,
#     rpcpuppetsync,
#     signal,
#     export,
#     exposed,
# )
from godot._builtins import *

# from godot.bindings import *
