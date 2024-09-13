# ~/.config/qtile
# Installation: <https://github.com/qtile/qtile>
# Documentation: <https://docs.qtile.org/en/stable>

from libqtile import bar, layout, qtile, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy

# ============ Prefrences ============
mod = "mod4"
mod1 = "mod1"
browser = "firefox"
files = "thunar"
terminal = "alacritty"

# ============ Colors ============
colors = ("#151515",  # 0 background
          "#d0d0d0",  # 1 foreground
          "#303030",  # 2 fade/grey
          "#fb9fb1",  # 3 red
          "#acc267",  # 4 green
          "#ddb26f",  # 5 yellow/orange
          "#6fc2ef",  # 6 blue
          "#e1a3ee",  # 7 magenta/purple
          "#12cfc0",  # 8 cyan
          )

# ============ Keybindings ============
keys = [
    # Launch programs
    Key([mod1], "Return", lazy.spawn(
        terminal), desc="Launch terminal"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),

    # Kill focused window
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),

    # Qtile
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),

    # Change focus
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(),
        desc="Move window focus to other window"),

    # Move windows
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(),
        desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(),
        desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Grow windows.
    # If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(),
        lazy.layout.increase_ratio(),
        lazy.layout.grow(),
        desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(),
        lazy.layout.increase_ratio(),
        lazy.layout.grow(),
        desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(),
        lazy.layout.decrease_ratio(),
        lazy.layout.shrink(),
        desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(),
        lazy.layout.decrease_ratio(),
        lazy.layout.shrink(),
        desc="Grow window up"),

    # Reset all window sizes
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window"),
    Key([mod], "t", lazy.window.toggle_floating(),
        desc="Toggle floating on the focused window"),
]

# Add key bindings to switch VTs in Wayland.
# We can't check qtile.core.name in default config as it is loaded before qtile is started
# We therefore defer the check until the key binding is run by using .when(func=...)
for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(
                func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )

# ============ Groups ============
groups = []
group_names = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

group_labels = ["", "", "", "", "", "", "", "", ""]
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
    # layout.Floating(border_focus=colors[4],
    #                 border_normal=colors[2]
    #                 ),
    # Try more layouts by unleashing below layouts.
    # layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4),
    # layout.Stack(num_stacks=2),
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
widget_defaults = dict(
    background=colors[0],
    font="Hack Nerd Font",
    fontsize=12,
    padding=2,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.Image(filename="~/.config/qtile/icons/python.png",
                             scale="False",
                             mouse_callbacks={
                                 'Button1': lambda: qtile.cmd_spawn(terminal)},
                             ),
                widget.GroupBox(active=colors[4],
                                borderwidth=5,
                                center_aligned=True,
                                disable_drag=True,
                                hide_unused=False,
                                highlight_method="line",
                                inactive=colors[2],
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
                widget.WindowName(),
                widget.Prompt(foreground=colors[6],
                              ignore_dups_history=True,
                              record_history=True,
                              max_history=500,
                              # prompt='{Run}: '
                              ),
                widget.Spacer(),
                widget.CurrentLayoutIcon(),
                widget.Memory(format="{MemUsed:.0f}{mm}",
                              foreground=colors[8]
                              ),
                widget.Clock(foreground=colors[7],
                             format="%a %d, %H:%M"
                             ),
                widget.Systray(padding=5),
                widget.QuickExit(countdown_start=10,
                                 countdown_format="[{}]",
                                 default_text="[X]"
                                 )
            ],
            24,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
    ),
]

# =========== Mouse & Floating ============
# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
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

auto_fullscreen = True
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

# =========== Autostart ============
# @hook.subscribe.startup_once
# def start_once():
#     home = os.path.expanduser('~')
#     subprocess.call([home + '/.config/qtile/scripts/autostart.sh'])
#

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
