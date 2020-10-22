# Compatible with ranger 1.6.0 through 1.7.*
#
# This is a sample plugin that displays "Hello World" in ranger's console after
# it started.

# We are going to extend the hook "ranger.api.hook_ready", so first we need
# to import ranger.api:
import ranger.api
import tempfile

# Save the previously existing hook, because maybe another module already
# extended that hook and we don't want to lose it:
old_hook_init = ranger.api.hook_init

# Create a replacement for the hook that...
import sys, os, curses
def hook_init(fm):
    # ...does the desired action...
    #fm.notify("Hello World")
    # ...and calls the saved hook.  If you don't care about the return value,
    # simply return the return value of the previous hook to be safe.
    fd = open(ranger.arg.confdir + '/rc.conf')

    settings = [ setting.rstrip() for setting in fd.readlines() ]
    if 'set as_directory_diff_tool false' in settings:
        fm.tempdir = ''
        fm.var = ''
        fd.close()
        return old_hook_init(fm)

    # Do some basic compare
    from ranger.diff import diff
    from time import sleep

    # test
    import traceback
    try:
        # init curses screen
        stdscr = curses.initscr( )

        curses.start_color()
        # stdscr.use_default_colors()
        curses.start_color()
        curses.init_pair(1, curses.COLOR_RED, 0)
        curses.init_pair(2, curses.COLOR_GREEN, curses.COLOR_GREEN)
        COLOR_RED    = curses.color_pair(1)
        COLOR_GREEN  = curses.color_pair(2)

        ranger.arg.diff_flag = True
        # Not used yet

        ranger.arg.files = [os.path.abspath(ranger.arg.targets[0]), os.path.abspath(ranger.arg.targets[1])]
        fm.files = ranger.arg.files

        fm.dir_diff = diff.DirDiff(ranger.arg.targets[0], ranger.arg.targets[1], '')
        fm.tempdir = tempfile.mkdtemp(prefix = 'rangerdiff', dir = '/tmp/')
        os.system('rm -rf %s && mkdir -p %s' % (fm.tempdir, fm.tempdir))
        fm.var = os.path.basename(ranger.arg.targets[0].rstrip('/'))
        os.system('cp -a %s %s/%s' % (ranger.arg.targets[1], fm.tempdir, fm.var))
        os.system('rsync -a %s/* %s/' % (ranger.arg.targets[0], '%s/%s' % (fm.tempdir, fm.var)))
        diff.showMessageDialog(message=fm.dir_diff.print_summary(), title='Summary of changes')
    except:
        curses.endwin( )

    ranger.arg.targets = []
    ranger.arg.targets.append('%s/%s/' % (fm.tempdir, fm.var))

    return old_hook_init(fm)

# Finally, "monkey patch" the existing hook_ready function with our replacement:
ranger.api.hook_init = hook_init


# Save the original filter function
import ranger.gui.widgets.browsercolumn
#old_draw_directory = ranger.gui.widgets.browsercolumn.BrowserColumn._draw_directory

# Define a new one
def new_draw_directory(self):
    """Draw the contents of a directory"""
    if self.image:
        self.image = None
        self.need_clear_image = True
        Pager.clear_image(self)

    if self.level > 0 and not self.settings.preview_directories:
        return

    base_color = ['in_browser']
    if self.fm.ui.viewmode == 'multipane' and self.tab is not None:
        active_pane = self.tab == self.fm.thistab
        if active_pane:
            base_color.append('active_pane')
        else:
            base_color.append('inactive_pane')
    else:
        active_pane = False

    self.win.move(0, 0)

    if not self.target.content_loaded:
        self.color(tuple(base_color))
        self.addnstr("...", self.wid)
        self.color_reset()
        return

    if self.main_column:
        base_color.append('main_column')

    if not self.target.accessible:
        self.color(tuple(base_color + ['error']))
        self.addnstr("not accessible", self.wid)
        self.color_reset()
        return

    if self.target.empty():
        self.color(tuple(base_color + ['empty']))
        self.addnstr("empty", self.wid)
        self.color_reset()
        return

    self._set_scroll_begin()

    copied = [f.path for f in self.fm.copy_buffer]

    selected_i = self._get_index_of_selected_file()
    for line in range(self.hei):
        i = line + self.scroll_begin
        if line > self.hei:
            break

        try:
            drawn = self.target.files[i]
        except IndexError:
            break

        tagged = self.fm.tags and drawn.realpath in self.fm.tags
        if tagged:
            tagged_marker = self.fm.tags.marker(drawn.realpath)
        else:
            tagged_marker = " "

        # Extract linemode-related information from the drawn object
        metadata = None
        current_linemode = drawn.linemode_dict[drawn._linemode]
        if current_linemode.uses_metadata:
            metadata = self.fm.metadata.get_metadata(drawn.path)
            if not all(getattr(metadata, tag)
                       for tag in current_linemode.required_metadata):
                current_linemode = drawn.linemode_dict[linemode.DEFAULT_LINEMODE]

        metakey = hash(repr(sorted(metadata.items()))) if metadata else 0
        key = (self.wid, selected_i == i, drawn.marked, self.main_column,
               drawn.path in copied, tagged_marker, drawn.infostring,
               drawn.vcsstatus, drawn.vcsremotestatus, self.target.has_vcschild,
               self.fm.do_cut, current_linemode.name, metakey, active_pane)

        if key in drawn.display_data:
            self.execute_curses_batch(line, drawn.display_data[key])
            self.color_reset()
            continue

        text = current_linemode.filetitle(drawn, metadata)

        if drawn.marked and (self.main_column or \
                self.settings.display_tags_in_all_columns):
            text = " " + text

        # Computing predisplay data. predisplay contains a list of lists
        # [string, colorlst] where string is a piece of string to display,
        # and colorlst a list of contexts that we later pass to the
        # colorscheme, to compute the curses attribute.
        predisplay_left = []
        predisplay_right = []
        space = self.wid

        # selection mark
        tagmark = self._draw_tagged_display(tagged, tagged_marker)
        tagmarklen = self._total_len(tagmark)
        if space - tagmarklen > 2:
            predisplay_left += tagmark
            space -= tagmarklen

        # vcs data
        vcsstring = self._draw_vcsstring_display(drawn)
        vcsstringlen = self._total_len(vcsstring)
        if space - vcsstringlen > 2:
            predisplay_right += vcsstring
            space -= vcsstringlen

        # info string
        infostring = []
        infostringlen = 0
        try:
            infostringdata = current_linemode.infostring(drawn, metadata)
            if infostringdata:
                infostring.append([" " + infostringdata + " ",
                                   ["infostring"]])
        except NotImplementedError:
            infostring = self._draw_infostring_display(drawn, space)
        if infostring:
            infostringlen = self._total_len(infostring)
            if space - infostringlen > 2:
                predisplay_right = infostring + predisplay_right
                space -= infostringlen

        textstring = self._draw_text_display(text, space)
        textstringlen = self._total_len(textstring)
        predisplay_left += textstring
        space -= textstringlen

        if space > 0:
            predisplay_left.append([' ' * space, []])
        elif space < 0:
            raise Exception("Error: there is not enough space to write "
                    "the text. I have computed spaces wrong.")

        # Computing display data. Now we compute the display_data list
        # ready to display in curses. It is a list of lists [string, attr]

        this_color = base_color + list(drawn.mimetype_tuple) + \
                self._draw_directory_color(i, drawn, copied)
        display_data = []
        drawn.display_data[key] = display_data

        predisplay = predisplay_left + predisplay_right
        for txt, color in predisplay:
            attr = self.settings.colorscheme.get_attr(*(this_color + color))
            display_data.append([txt, attr])

        self.execute_curses_batch(line, display_data)
        self.color_reset()

import ranger.gui.widgets.browsercolumn
ranger.gui.widgets.browsercolumn.BrowserColumn._draw_directory = new_draw_directory


import ranger.gui.widgets.browsercolumn
old_draw_infostring_display = ranger.gui.widgets.browsercolumn.BrowserColumn._draw_infostring_display

def new_draw_infostring_display(self, drawn, space):
    if not self.settings.as_directory_diff_tool:
        return old_draw_infostring_display(self, drawn, space)
    infostring_display = []
    if self.display_infostring and drawn.infostring \
            and self.settings.display_size_in_main_column:

        # Print differents to the screen
        curfile = drawn.realpath.replace('%s/%s/' % (self.fm.tempdir, self.fm.var), '')
        if self.fm.dir_diff.is_removed(curfile):
            drawn.infostring = '  +  '
            #if os.path.isdir(curfile):
            #    drawn.infostring = '+ -'
        elif self.fm.dir_diff.is_added(curfile):
            drawn.infostring = '    +'
            #if os.path.isdir(curfile):
            #    drawn.infostring = '+ -'
        elif self.fm.dir_diff.is_modified(curfile):
            drawn.infostring = '  + -'
        else:
            drawn.infostring = '     '
        infostring = str(drawn.infostring) + " "
        if len(infostring) <= space:
            infostring_display.append([infostring, ['infostring']])
    return infostring_display

import ranger.gui.widgets.browsercolumn
ranger.gui.widgets.browsercolumn.BrowserColumn._draw_infostring_display = new_draw_infostring_display
