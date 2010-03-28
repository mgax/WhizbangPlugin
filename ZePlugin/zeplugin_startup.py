import Cocoa

invoke_handlers = {}
register_handler = invoke_handlers.__setitem__

class PyLink(Cocoa.NSObject):
    def invokeWith_(self, kwargs):
        kwargs = dict( (str(k), v) for k, v in kwargs.iteritems() )
        event_name = kwargs.pop("invocation_name")
        handler = invoke_handlers.get(event_name, None)
        if handler is not None:
            handler(**kwargs)

def link_to_bundle(pth):
    url = Cocoa.NSURL.fileURLWithPath_(pth)
    bundle = Cocoa.NSBundle.bundleWithURL_(url)
    Plugin = bundle.principalClass()
    Plugin.setPyLink_(PyLink.new())

def load_user_config():
    import os
    from os import path
    config_path = path.join(os.environ['HOME'], '.wizbang.py')
    if path.isfile(config_path):
        execfile(config_path, {'__builtins__': __builtins__})

link_to_bundle(bundle_path)
load_user_config()
