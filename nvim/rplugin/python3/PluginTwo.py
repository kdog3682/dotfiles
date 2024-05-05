import pynvim

@pynvim.plugin
class MyNeovimPlugin(object):
    def __init__(self, nvim):
        self.nvim = nvim

    # @pynvim.autocmd('VimEnter', pattern='*', sync=True)
    def on_vim_enter(self):
        self.nvim.out_write("This Python function runs after pynvim starts.\n")

