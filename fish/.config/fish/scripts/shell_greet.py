import datetime


time_greeting_map = {
    "good morning": [*range(4, 12)],
    "good and productive day": [*range(12, 17)],
    "good evening": [*range(17, 21)],
    "good night, sunshine (you probably should go sleep dude)": [
        *([i for i in range(21, 24)] + [i for i in range(0, 4)])
    ]
}

def greet_by_time(
    time: datetime.datetime, 
    time_map: dict[str, list[int]]
) -> str:
    hour: int = time.hour
    for greet, hours in time_map.items():
        if hour in hours:
            return greet
    return "hello"



try:
    from sty import fg
except ImportError as er:
    print(greet_by_time(datetime.datetime.now(), time_greeting_map))
    print("It's looks like you doesn't have install `sty` module.")
    print("Better consider download it.")
    print("(◕ᴥ◕ʋ)")
    raise SystemExit(1)


art = \
    "          # #### ####              \n" \
  + "        ### \\/#|### |/####        \n" \
  + "       ##\\/#/ \\||/##/_/##/_#     \n" \
  + "     ###  \\/###|/ \\/ # ###       \n" \
  + "   ##_\\_#\\_\\## | #/###_/_####   \n" \
  + "  ## #### # \\ #| /  #### ##/##    \n" \
  + "   __#_--###`  |{,###---###-~      \n" \
  + "             \\ }{                 \n" \
  + "              }}{                  \n" \
  + "              }}{                  \n" \
  + "         ejm  {{}                  \n" \
  + "        , -=-~{ .-^- _             \n" \
  + "              `}                   \n" \
  + "               {                     "


colors = {
    "green": (0, 204, 102),
    "blue" : (0, 204, 204),
    "brown": (204, 102, 0),
}


char_colors = {
    "green": "#^",
    "blue" : "ejm|\\/_-`}{~=.,",
    # "blue" : "",
}


def get_color_for_char(char: str, color_map: dict[str, str]) -> str:
    for color, chars in color_map.items():
        if char in chars:
            return color
    print(char)
    return "gray"


colored_art = ""

for char in art:
    if char == " " or char == "\n":
        colored_art += char
        continue
    color_name = get_color_for_char(char, char_colors)
    color_rgb = colors[color_name]
    colored_art += fg(*color_rgb) + char + fg.rs 


coffee_cup = fg(*colors["brown"]) + '\ue61b ' + fg.rs
laptop = fg.blue + '\uf821 ' + fg.rs
sunset = fg.yellow + '\uf762 ' + fg.rs
night_star = fg.yellow + '\ue370 ' + fg.rs


colored_greetings = {
    f"{coffee_cup} good morning": [*range(4, 12)],
    f"{laptop} good and productive day": [*range(12, 17)],
    f"{sunset} good evening": [*range(17, 21)],
    f"{night_star} good night, sunshine (you probably should go sleep dude)": [
        *([i for i in range(21, 24)] + [i for i in range(0, 4)])
    ]
}

# now = datetime.datetime.fromisoformat("2022-09-14T14:00")
now = datetime.datetime.now()

print(colored_art)
print()
print(
    fg(*colors["blue"])
  + greet_by_time(now, colored_greetings)
  + fg.rs
)

