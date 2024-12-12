#!/usr/bin/env python
#
# This module is designed to easily switch following tofi-paramters at run-time
# 1. font family
# 2. font size
# 3. theme
#
# Known Issues:
# TODO: font-command doesn't include fonts which contain '-' in their respective names
# To solve it locally, you may try following:
#
# Remove "| grep -v -" from FONT_COMMAND but then you will include font styles like:
# 1. FiraCode-Italic
# 2. FiraCode-Bold
# This styles are not really accepted by tofi.
#
# So, will have to remove all styles by adding:
# 1. "| grep -v -Italic"
# 2. "| grep -v -Bold"
# and so on.
#
# Known Issues accepted as limitations:
# ISSUE: config-path doesn't check the value configured by ${XDG_HOME}
# ISSUE: various errors are not handled related to files like: no read permissions etc.

import os
import os.path
import getpass


VERSION = "0.0.1"
MODULE = __name__ if __name__ != "__main__" else "tofi"
CONFIG_PATH = os.path.expanduser("~/.config/tofi/")
FONT_COMMAND = "fc-list | cut -d '/' -f 6- | cut -d '.' -f 1-1 | cut -d '[' -f 1-1 | sort | uniq | grep -v -"
DEFAULT_FONT = "FiraCode"
DEFAULT_SIZE = "9"

FONT_FILE = CONFIG_PATH + "font"
FONT_LINE = 1
SIZE_LINE = 2

THEME_LINK = CONFIG_PATH + "theme"
THEMES_DIR = CONFIG_PATH + "themes/"


# Private function to check/log version
def __version():
    return "\nModule - " + MODULE + "\nVersion - " + VERSION + "\n"


# Private function to sym-link destination to source
def __link(src, dest):
    # Try to unlink the destination (if already exists)
    try:
        os.unlink(dest)
    except FileNotFoundError:
        pass

    # Make the destination link to the source
    os.symlink(src, dest)


# Private function to overwrite a file
def __rewrite(path, content):
    file = open(path, "w")
    file.write(content)
    file.close()


# Private function to display warning if program runs as a script
def __warning():
    print(
        "\033[91m"
        + "\033[4m"
        + 'Hello, "{user:}"'.format(user=getpass.getuser())
        + "\nThis program is not designed to run as a script."
        + "\033[0m"
    )

    print(
        "\033[93m"
        + "\033[4m"
        + "\033[1m"
        + "\nYou probably would want to import this python module:\n"
        + "- in some main helper-program\n"
        + "- or in a python-shell.\n"
        + "\033[0m"
        + "\033[4m"
        + "\033[92m"
        + "\nExample: Running using a python shell:\n"
        + "\033[0m"
        + "$ python\n"
        + ">>> import tofi\n"
        + ">>> tofi.help()\n"
        + ">>> exit()\n"
    )


USAGE_CHECK_FONT = """
Public function to check installed fonts:
{module:}.check_font("Mono")             - returns all installed fonts containing "Mono"     (such as: JetBrainsMono, NavaMono etc.)
{module:}.check_font("Code")             - returns all installed fonts contianing "Code"     (such as: SourceCodePro, FiraCode etc.)
""".format(module=MODULE)

USAGE_CHECK_THEME = """
Public function to check available themes and other related required-parameters:
{module:}.check_theme("dir")             - prints path of the directory containing tofi-themes
{module:}.check_theme("link")            - prints path of the link used to configure tofi-themes
{module:}.check_theme("path")            - prints path of the current tofi-theme (being used)
{module:}.check_theme("list")            - print all the available tofi-themes
""".format(module=MODULE)

USAGE_GET_FONT = """
Public function to read configured font style:
{module:}.get_font()                     - prints the font (being used for tofi)
""".format(module=MODULE)

USAGE_GET_SIZE = """
Public function to read configured font size:
{module:}.get_size()                     - prints the font-size (being used for tofi)
""".format(module=MODULE)

USAGE_GET_THEME = """
Public function to read configured theme:
{module:}.get_theme()                    - prints the theme-name (being used for tofi)
""".format(module=MODULE)

USAGE_SET_FONT = """
Public function to configure font style:
{module:}.set_font("FiraCode")           - configures the tofi-font to "FiraCode"
""".format(module=MODULE)

USAGE_SET_SIZE = """
Public function to configure font size:
{module:}.set_size(9)                    - configures the tofi-font-size to 9
""".format(module=MODULE)

USAGE_SET_THEME = (
    "\nAvailable Themes:\n"
    + str(os.listdir(THEMES_DIR))
    + "\n"
    + """
Public function to configure theme:
{module:}.set_theme("glass-top")         - Configures the new tofi-theme to "glass-top"
{module:}.set_theme("glass-right")       - Configures the new tofi-theme to "glass-right"
""".format(module=MODULE)
)

USAGE_HELP = """
Public function to check usage of this module:
{module:}.help("all")                    - Prints the usage of all functions
{module:}.help("font")                   - Prints the usage of all font relateed functions
{module:}.help("size")                   - Prints the usage of all size relateed functions
{module:}.help("theme")                  - Prints the usage of all theme relateed functions
{module:}.help("help")                   - Prints the usage of help function
""".format(module=MODULE)

USAGE_ALL = (
    str(__version())
    + USAGE_CHECK_FONT
    + USAGE_CHECK_THEME
    + USAGE_GET_FONT
    + USAGE_GET_SIZE
    + USAGE_GET_THEME
    + USAGE_SET_FONT
    + USAGE_SET_SIZE
    + USAGE_SET_THEME
    + USAGE_HELP
)


# Public function to check available fonts
def check_font(name):
    os.system(FONT_COMMAND + " | grep " + str(name))


# Public function to read configured font style
def get_font():
    lineno = FONT_LINE - 1

    try:
        file = open(FONT_FILE)
        lines = file.readlines()
        content = lines[lineno]
        line = content.split("= ")[1]
    except (FileNotFoundError, IndexError):
        return DEFAULT_FONT

    value = line.rstrip("\n").strip('"')
    return value


# Public function to read configured font size
def get_size():
    lineno = SIZE_LINE - 1

    try:
        file = open(FONT_FILE)
        lines = file.readlines()
        content = lines[lineno]
        line = content.split("= ")[1]
    except (FileNotFoundError, IndexError):
        return DEFAULT_SIZE

    value = line.rstrip("\n").strip('"')
    return value


# Public function to configure font style
def set_font(value):
    name = value
    size = int(get_size())

    content = "font = " + str(name) + "\n" + "font-size = " + str(size) + "\n"
    __rewrite(FONT_FILE, content)


# Public function to configure font size
def set_size(value):
    name = get_font()
    size = int(value)

    content = "font = " + str(name) + "\n" + "font-size = " + str(size) + "\n"
    __rewrite(FONT_FILE, content)


# Public function to check available themes and other required-parameters (related to themes)
def check_theme(option):
    match option:
        case "list":
            list = os.listdir(THEMES_DIR)
            print(list)
        case "path":
            path = os.path.realpath(THEME_LINK)
            print(path)
        case "dir":
            print(THEMES_DIR)
        case "link":
            print(THEME_LINK)
        case _:
            print(USAGE_CHECK_THEME)


# Public function to read configured theme
def get_theme():
    path = os.path.realpath(THEME_LINK)
    return os.path.basename(path)


# Public function to configure theme
def set_theme(target):
    available = False
    for theme in os.listdir(THEMES_DIR):
        if theme == target:
            available = True
            break

    if not available:
        print("Unable to find: " + THEMES_DIR + target)
        print(USAGE_SET_THEME)
        return

    __link(THEMES_DIR + target, THEME_LINK)


# Public function to check usage of this module
def help(action="all"):
    match action:
        case "font":
            print(USAGE_CHECK_FONT)
            print(USAGE_GET_FONT)
            print(USAGE_SET_FONT)
        case "size":
            print(USAGE_GET_SIZE)
            print(USAGE_SET_SIZE)
        case "theme":
            print(USAGE_CHECK_THEME)
            print(USAGE_GET_THEME)
            print(USAGE_SET_THEME)
        case "help":
            print(USAGE_HELP)
        case _:
            print(USAGE_ALL)


if __name__ == "__main__":
    __warning()
