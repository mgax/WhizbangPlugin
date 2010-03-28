print "starting up with %r" % bundle_path
import Cocoa

url = Cocoa.NSURL.fileURLWithPath_(bundle_path)
bundle = Cocoa.NSBundle.bundleWithURL_(url)
Plugin = bundle.principalClass()

class PyLink(Cocoa.NSObject):
    def sayHello(self):
        print "Hello there!"

    def invokeWith_(self, kwargs):
        print kwargs

Plugin.setPyLink_(PyLink.new())
