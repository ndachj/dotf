# ~/.config/qtile

# Requirements: Nerd Font, rofi, alacritty, thunar, firefox, scrot
# Python Requirements: psutil

# import os

from libqtile import bar, layout, qtile, widget
from libqtile.config import Click, Drag, Group, Key, KeyChord, Match, Screen
from libqtile.lazy import lazy

# ============ Prefrences ============
mod = "mod4"  # Super/Window key
mod1 = "mod1"  # Alt key
browser = "firefox"
files = "thunar"
terminal = "alacritty"
rofi = "rofi -show drun"

# ============ Colors ============
# Base16-chalk <https://github.com/chriskempson/base16>
colors = ("#151515",  # 0 background
          "#d0d0d0",  # 1 foreground
          "#202020",  # 2 black
          "#fb9fb1",  # 3 red
          "#acc267",  # 4 green (main)
          "#ddb26f",  # 5 yellow
          "#6fc2ef",  # 6 blue
          "#e1a3ee",  # 7 magenta
          "#12cfc0",  # 8 cyan
          "#505050")  # 9 grey

# =========== Autostart ============
# @hook.subscribe.startup_once
# def autostart():
#     home = os.path.expanduser('~/.config/qtile/autostart.sh')
#     subprocess.Popen([home])

# =========== Functions ============

# ============ Keybindings ============
keys = [

    # Launch programs
    Key([mod1], "Return",
        lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "F1",
        lazy.spawn(browser), desc="Launch browser"),
    Key([mod1], "F2",
        lazy.spawn(files), desc="Launch file manager"),
    Key([mod], "p",
        lazy.spawn(rofi), desc="Launch rofi"),

    # Close the focused window
    Key([mod], "q",
        lazy.window.kill(), desc="Close the focused window"),

    # Qtile
    Key([mod, "control"], "r",
        lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q",
        lazy.shutdown(), desc="Shutdown Qtile"),

    # Change focus
    Key([mod], "h",
        lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l",
        lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j",
        lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k",
        lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space",
        lazy.layout.next(), desc="Move window focus to other window"),

    # Move windows
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h",
        lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l",
        lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j",
        lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k",
        lazy.layout.shuffle_up(), desc="Move window up"),

    # Resize windows
    # If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    KeyChord([mod], "r", [
        Key([], "h",
            lazy.layout.grow_left(),
            desc="Resize window to the left"),
        Key([], "l",
            lazy.layout.grow_right(),
            desc="Resize window to the right"),
        Key([], "j",
            lazy.layout.grow_down(),
            lazy.layout.grow(),
            desc="Resize window down"),
        Key([], "k",
            lazy.layout.grow_up(),
            lazy.layout.shrink(),
            desc="Resize window up"),
    ],
             mode=True,
             name="Resize"
             ),

    # Reset all window sizes
    Key([mod], "n",
        lazy.layout.normalize(), desc="Reset all window sizes"),

    # Toggle a client window between its minimum and maximum sizes
    Key([mod], "m",
        lazy.layout.maximize(), desc="Toggle window max or min size"),

    # Toggle between different layouts as defined below
    Key([mod], "Tab",
        lazy.next_layout(), desc="Toggle between layouts"),

    # Toggle fullscreen
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window"),

    # Toggle floating
    Key([mod], "t", lazy.window.toggle_floating(),
        desc="Toggle floating on the focused window"),

    # Change the volume if your keyboard has special volume keys.
    Key(
        [], "XF86AudioRaiseVolume",
        lazy.spawn("amixer -c 0 -q set Master 2dB+")
    ),
    Key(
        [], "XF86AudioLowerVolume",
        lazy.spawn("amixer -c 0 -q set Master 2dB-")
    ),
    Key(
        [], "XF86AudioMute",
        lazy.spawn("amixer -c 0 -q set Master toggle")
    ),

    # Also allow changing volume the old fashioned way.
    Key([mod], "equal",
        lazy.spawn("amixer -c 0 -q set Master 2dB+")),
    Key([mod], "minus",
        lazy.spawn("amixer -c 0 -q set Master 2dB-")),
]

# Add key bindings to switch VTs in Wayland.
# We can't check qtile.core.name in default config as it is loaded before qtile is started
# We therefore defer the check until the key binding is run by using .when(func=...)
# for vt in range(1, 8):
#     keys.append(
#         Key(
#             ["control", "mod1"],
#             f"f{vt}",
#             lazy.core.change_vt(vt).when(
#                 func=lambda: qtile.core.name == "wayland"),
#             desc=f"Switch to VT{vt}",
#         )
#     )

# ============ Groups ============
groups = []
group_names = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

group_labels = ["", "", "", "", "", "", "", "", "󰊗"]
# group_labels = ["DEV", "WWW", "SYS", "DOC", "VBOX", "CHAT", "MUS", "VID", "GFX",]

group_layouts: list[str] = ["monadtall", "monadtall", "monadtall", "monadtall",
                            "monadtall", "monadtall", "monadtall", "monadtall", "treetab"]

for i in range(len(group_names)):
    groups.append(Group(
        name=group_names[i],
        layout=group_layouts[i].lower(),
        label=group_labels[i]
    ))

for i in groups:
    keys.extend(
        [
            # mod + group number = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc=f"Switch to group {i.name}",
            ),
            # mod + shift + group number = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc=f"Switch to & move focused window to group {i.name}",
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod + shift + group number = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )


# =========== Layout ============
layouts = [
    layout.MonadTall(border_focus=colors[4],
                     border_normal=colors[2],
                     border_width=2,
                     margin=2,
                     max_ratio=0.75,
                     min_ratio=0.50,
                     # ratio=0.6
                     ),
    # TreeTab works just like Max
    layout.TreeTab(active_bg=colors[4],
                   active_fg="#000000",
                   bg_color=colors[0],
                   border_width=2,
                   fontsize=14,
                   inactive_bg=colors[2],
                   inactive_fg="#ffffff",
                   level_shift=8,
                   place_right=True,  # Place the tab panel on the right side
                   sections=["> MAIN"],
                   section_fontsize=14,
                   urgent_bg=colors[2],
                   urgent_fg=colors[3],
                   vspace=3
                   ),
    # layout.Floating(border_focus=colors[5],
    #                 border_normal=colors[2]
    #                 ),
    # Try more layouts by unleashing below layouts.
    # layout.Columns(),
    # layout.Stack(),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.Max(),
    # layout.MonadWide(),
    # layout.MonadThreeCol(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.VerticalTile(),
    # layout.Slice(),
    # layout.Spiral(),
    # layout.Stack(),
    # layout.Zoomy(),
]

# =========== Widgets ============
# Emulate (Neo)Vim statusline

# Default settings for extensions/widgets
widget_defaults = dict(
    background=colors[2],
    foreground=colors[1],
    font="Hack Nerd Font",
    fontsize=12,
    padding=2,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayoutIcon(),
                widget.GroupBox(active=colors[4],
                                borderwidth=5,
                                center_aligned=True,
                                disable_drag=True,
                                hide_unused=False,
                                highlight_method="line",
                                inactive=colors[9],
                                margin=3,
                                padding=4,
                                rounded=False,
                                scroll=False,
                                scroll_hide=False,
                                this_current_screen_border=colors[4],
                                this_screen_border=colors[4],
                                urgent_alert_method="block",
                                urgent_border=colors[3],
                                urgent_text=colors[3],
                                use_mouse_wheel=True
                                ),
                widget.WindowName(background=colors[0]),
                widget.Chord(background=colors[6],
                             foreground="#ffffff",
                             ),
                widget.Spacer(background=colors[0]),
                # widget.Systray(padding=5),
                # widget.Notify(),
                # widget.Net(fmt="󰀂 {} ",
                #            format="{down:.0f}{down_suffix} ↓↑ {up:.0f}{up_suffix}"
                #            ),
                widget.Memory(fmt="󰍛 {} ",
                              format="{MemUsed:.0f}{mm}",
                              ),
                # widget.CPU(fmt="  {} "),
                widget.CheckUpdates(fmt="󰚰 {} ",
                                    no_update_string="0"
                                    ),
                widget.Clock(fmt="󰃰 {} ",
                             format="%a %d, %H:%M"
                             ),
                widget.QuickExit(foreground=colors[3],
                                 countdown_start=15,
                                 countdown_format="[{}]",
                                 default_text="󰈆 "
                                 )
            ],
            24,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000",
            #               "ff00ff", "000000"]  # Borders are magenta
        ),
    ),
]

# =========== Mouse ============
# Button1: Left click
# Button2: Middle click
# Button3: Right click
# Button4: Scroll up
# Button5: Scroll down
mouse = [
    # drag the window around as a floating
    Drag([mod], "Button1",
         lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    # resize the window (and also make it float if it is not already floating)
    Drag([mod], "Button3",
         lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    # bring the window to the front
    Click([mod], "Button2",
          lazy.window.bring_to_front()),
]

# Controls whether or not focus follows the mouse around as it
# moves across windows in a layout.
follow_mouse_focus = True

# When clicked, should the window be brought to the front or not.
# option: False, floating_only, True
bring_front_click = False

# =========== Floating ============
dgroups_key_binder = None

dgroups_app_rules = []  # type: list

# Floating windows are kept above tiled windows (Currently x11 only)
floats_kept_above = True

floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),   # gitk
        Match(wm_class="dialog"),         # dialog boxes
        Match(wm_class="download"),       # downloads
        Match(wm_class="error"),          # error msgs
        Match(wm_class="file_progress"),  # file progress boxes
        Match(wm_class='kdenlive'),       # kdenlive
        Match(wm_class="makebranch"),     # gitk
        Match(wm_class="maketag"),        # gitk
        Match(wm_class="notification"),   # notifications
        Match(wm_class='pinentry-gtk-2'),  # GPG key password entry
        Match(wm_class="ssh-askpass"),    # ssh-askpass
        Match(wm_class="toolbar"),        # toolbars
        Match(wm_class="Yad"),            # yad boxes
        Match(title="branchdialog"),      # gitk
        Match(title='Confirmation'),      # tastyworks exit box
        Match(title='Qalculate!'),        # qalculate-gtk
        Match(title="pinentry"),          # GPG key password entry
    ]
)

# =========== Others Options ============
# If a window requests to be fullscreen, it is automatically fullscreened.
# Set this to false if you only want windows to be fullscreen
# if you ask them to be.
auto_fullscreen = True

# option: urgent, focus, smart, never
focus_on_window_activation = "smart"

reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# xcursor theme (string or None) and size (integer) for Wayland backend
wl_xcursor_theme = None
wl_xcursor_size = 24

# cursor follows the focus as directed by the keyboard, warping to the center
# of the focused window.
cursor_warp = False

# impersonate LG3D so java swing apps work
wmname = "LG3D"
