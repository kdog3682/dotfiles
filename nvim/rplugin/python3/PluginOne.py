import pynvim

@pynvim.plugin
class MyNeovimPlugin(object):
    def __init__(self, nvim):
        self.nvim = nvim

