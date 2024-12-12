import sys
import tofi

VERSION = "0.0.1"
program = sys.argv[0]
operation = "help"
command = "help"
argument = None


def help(program, command):
    print("{}: {}".format(program, command))


def run_action(program, operation, command=None, argument=None):
    if program == "tofi":
        match command:
            case "font":
                match operation:
                    case "check":
                        return tofi.check_font(argument)
                    case "set":
                        if argument is not None:
                            return tofi.set_font(argument)
                    case "get":
                        return tofi.get_font()

            case "size":
                match operation:
                    case "set":
                        if argument is not None:
                            return tofi.set_size(argument)
                    case "get":
                        return tofi.get_size()

            case "theme":
                match operation:
                    case "check":
                        if argument is not None:
                            return tofi.check_theme(argument)
                    case "set":
                        if argument is not None:
                            return tofi.set_theme(argument)
                    case "get":
                        return tofi.get_theme()

    return help(program, command)


for arg in sys.argv:
    match arg:
        case "-v" | "--ver" | "--version" | "-V" | "--Version" | "version":
            command = "version"
        case "-h" | "--help" | "help":
            operation = "help"
        case "-s" | "--set" | "set":
            operation = "set"
        case "-g" | "--get" | "get":
            operation = "get"
        case "-c" | "--chk" | "--check" | "check":
            operation = "check"
        case "hyprswitch" | "kitty" | "tofi":
            program = arg
        case "font" | "size" | "theme" | "help":
            command = arg
        case _:
            argument = arg

result = run_action(program, operation, command, argument)
if result:
    print("{}".format(result))
