{ config, lib, pkgs, ... }:

{
  programs.zsh.profileExtra = ''
    if [ -z "$DISPLAY" ] && [ "''\${XDG_VTNR:-0}" -eq 1 ]; then
      exec sway
    fi
  '';

  gtk = {
    enable = true;
  };

  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 300;
        command = ''${pkgs.sway}/bin/swaymsg "output * power off" '';
        resumeCommand = ''${pkgs.sway}/bin/swaymsg "output * power on"'';
      }
    ];
  };

  wayland.windowManager.sway = {
    enable = true;
    checkConfig = true;
    wrapperFeatures.gtk = true;
    config = rec {
      modifier = "Mod1";
      terminal = "kitty";
      left = "h";
      down = "n";
      up = "e";
      right = "l";
      startup = [
        { command = "kitty"; }
        { command = "google-chrome-stable"; }
      ];
      menu = "bemenu-run | xargs swaymsg exec --";
      input = {
        "type:keyboard" = {
          xkb_layout = "us";
          xkb_variant = "colemak";
          repeat_rate = "56";
          repeat_delay = "200";
        };
      };
      focus.followMouse = false;
      floating.modifier = modifier;
      keybindings = lib.mkForce {
        "${modifier}+return" = "exec ${terminal}";
        "${modifier}+space" = "exec ${menu}";
        "${modifier}+shift+q" = "kill";
        # "${modifier}+shift+c" = "reload";
        "${modifier}+s" = "splith";
        "${modifier}+f" = "layout tabbed";
        "${modifier}+shift+f" = "layout toggle split";
        "${modifier}+t" = "fullscreen toggle";
#     # Move the focused window with the same, but add Shift
        "${modifier}+shift+${left}" = "move left";
        "${modifier}+shift+${down}" = "move down";
        "${modifier}+shift+${up}" = "move up";
        "${modifier}+shift+${right}" = "move right";
#     # Ditto, with arrow keys
        "${modifier}+shift+Left" = "move left";
        "${modifier}+shift+Down" = "move down";
        "${modifier}+shift+Up" = "move up";
        "${modifier}+shift+Right" = "move right";
        "XF86AudioRaiseVolume" = "exec 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.0'";
        "XF86AudioLowerVolume" = "exec 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- -l 1.0'";
        "XF86AudioMute" = "exec 'wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle'";
        "Print" = "exec 'FILENAME=\"screenshot-`date +%F-%T`\"; grim -g \"$(slurp)\" ~/Downloads/$FILENAME.png '";
        "${modifier}+n" = "focus left";
        "${modifier}+e" = "focus right";
        "${modifier}+h" = "focus down";
        "${modifier}+l" = "focus up";
        "${modifier}+o" = "focus parent";
        "${modifier}+i" = "focus child";

        "${modifier}+shift+minus" = "move scratchpad";
        "${modifier}+minus" = "scratchpad show";

        "${modifier}+shift+r" = "mode resize";

        # Switch to workspace
        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";
        "${modifier}+6" = "workspace number 6";
        "${modifier}+7" = "workspace number 7";
        "${modifier}+8" = "workspace number 8";
        "${modifier}+9" = "workspace number 9";
        "${modifier}+0" = "workspace number 10";
        # Move focused container to workspace
        "${modifier}+Shift+1" = "move container to workspace number 1";
        "${modifier}+Shift+2" = "move container to workspace number 2";
        "${modifier}+Shift+3" = "move container to workspace number 3";
        "${modifier}+Shift+4" = "move container to workspace number 4";
        "${modifier}+Shift+5" = "move container to workspace number 5";
        "${modifier}+Shift+6" = "move container to workspace number 6";
        "${modifier}+Shift+7" = "move container to workspace number 7";
        "${modifier}+Shift+8" = "move container to workspace number 8";
        "${modifier}+Shift+9" = "move container to workspace number 9";
        "${modifier}+Shift+0" = "move container to workspace number 10";
#
        "${modifier}+Home" = "exec --no-startup-id pkill -USR1 redshift";
      };
      bars = [
        {
          position = "top";
          command = "waybar";
        }
      ];
    };
  extraConfig = ''
default_border pixel 1
# borders, lol
hide_edge_borders both
titlebar_padding 1 1
'';
  };
}