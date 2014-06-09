# -*- mode: snippet -*-
# name: interface
# key: inter
# --
public interface ${1:`(file-name-sans-extension (buffer-name))`} : GLib.Object $2 
{
    $0
}
