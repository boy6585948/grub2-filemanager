# Grub2-FileManager
# Copyright (C) 2017  A1ive.
#
# Grub2-FileManager is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Grub2-FileManager is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Grub2-FileManager.  If not, see <http://www.gnu.org/licenses/>.

if [ "$theme" != "${prefix}/themes/slack/theme.txt" ]; then
	echo "Loading theme ... ";
	set theme=${prefix}/themes/slack/theme.txt; export theme;
fi;
function hidden_menu {
	hiddenentry "Settings" --hotkey=s {
		configfile $prefix/settings.sh;
	}
	hiddenentry "Lua" --hotkey=l {
		lua;
	}
	hiddenentry "Boot" --hotkey=b {
		if [ "$boot_func" = "osdetect" ]; then
			action="osdetect"; export action; configfile $prefix/clean.sh;
		else
			configfile $prefix/boot.sh;
		fi;
	}
	hiddenentry "Reboot" --hotkey=r {
		reboot;
	}
	hiddenentry "Halt" --hotkey=h {
		halt;
	}
}
if [ "$action" = "open" ]; then
	hidden_menu;
	lua $prefix/open.lua;
elif [ "$action" = "osdetect" ]; then
	lua $prefix/osdetect.lua;
else
	hidden_menu;
	lua $prefix/main.lua;
fi;