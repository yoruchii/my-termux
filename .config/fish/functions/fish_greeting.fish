function fish_greeting                                       if not set -q fish_greeting
        set -l line1 (printf (_ '│ %s>> %sSystem boot: fish-shell %sonline%s. │') (set_color 83a598) (set_color normal) (set_color -b 8ec07c 665c54) (set_color normal))
        set -l line2 \n(printf (_ '│ %s>> %sInput %shelp%s for instructions.    │') (set_color 83a598) (set_color normal) (set_color -b 8ec07c 665c54) (set_color normal))
        set -l line3 \n╰────────────────────────────────────╯
        set -g fish_greeting "$line1$line2$line3"
    end

    if set -q fish_private_mode
        set -l line (_ "fish is running in private mode, history will not be persisted.")
        if set -q fish_greeting[1]
            set -g fish_greeting $fish_greeting\n$line           else
            set -g fish_greeting $line
        end
    end

    # The greeting used to be skipped when fish_greeting was empty (not just undefined)                               # Keep it that way to not print superfluous newlines on old configuration
    test -n "$fish_greeting"
    and echo $fish_greeting
end
