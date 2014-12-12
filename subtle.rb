#
# This program can be distributed under the terms of the GNU GPL.
# See the file COPYING.
#
# $Id: .config/subtle/subtle.rb,v 403 2011/11/08 16:03:21 unexist $
#

require "socket"

# Contrib {{{
begin
  require "#{ENV["HOME"]}/bin/launcher/launcher.rb"
  require "#{ENV["HOME"]}/selector.rb"

  Subtle::Contrib::Selector.font  = "xft:Dejavu Sans Mono-9:antialias=true:hinting=true:hintstyle=medium"
  Subtle::Contrib::Launcher.fonts = [
    "xft:Dejavu Sans Mono:bold:pixelsize=40",
    "xft:Dejavu Sans Mono:bold:pixelsize=10"
  ]

  Subtle::Contrib::Launcher.browser_screen_num = 0
rescue LoadError
end # }}}

 # Options {{{
set :step,      5
set :snap,      10
set :gravity,   :center
set :urgent,    true
set :resize,    false
set :tiling,    false
set :skip_pointer_warp, false
# }}}
#   Screens {{{
screen 1 do
arch = Subtlext::Icon.new("/home/paul/.icons/subtle/subtle1.xbm")
cloud = Subtlext::Icon.new("/home/paul/.icons/subtle/subtle2.xbm")
top     [ :spacer, :mpd, :separator, cloud, :meteoprog, :spacer ]
bottom [ :views, :separator, :title, :spacer, :separator, :cpucolored, :separator, :battery, :separator, :nettraffic, :separator, :clock2, :separator, :tray, :separator, arch ]
end

# }}}

# Colours { {{
   background_1 =   "#181512"
   background_2 =   "#212121"    

   color_above =    "#373737"
   color_light =    "#a6594a"
   color_medium =   "#DCC58F"
   color_dark =     "#3F5454"
# }}}
   
# Styles {{{
style :all do
  icon         color_light
  padding 0, 3, 3, 3   
  font       "xft:Dejavu Sans:regular:size=13"
end

style :title do
  foreground   color_medium
  background   background_1
end

style :views do
  foreground   color_medium
  background   background_1
  icon         color_medium

  style :focus do
    foreground    color_medium
    background    color_light
    icon          color_medium
  end

  style :occupied do
    foreground    color_light
    background    background_1
    icon          color_light
  end

  style :urgent do
  foreground    color_light
  background    background_1
  icon          color_light
  end
end

style :sublets do
    foreground   color_medium
    background   background_1
    icon         color_light
  end

style :clients do
    active       color_light, 2
    inactive     color_medium, 2
  margin  10
end

style :separator do
    foreground   background_1
    background   background_1
    separator    " | "
end
                                  
style :subtle do
  margin 0, 0, 0, 0
  panel_top background_1
  panel_bottom background_1
end  # }}} 

# Gravities {{{
# Top Left
gravity :top_left,       [   0,   0,  50,  50 ] 
gravity :top_left66,     [   0,   0,  50,  66 ] 
gravity :top_left33,     [   0,   0,  50,  34 ] 

gravity :top,            [   0,   0, 100,  50 ]
gravity :top66,          [   0,   0, 100,  66 ]
gravity :top33,          [   0,   0, 100,  34 ]

# Top right
gravity :top_right,      [  50,   0,  50,  50 ]
gravity :top_right66,    [  50,   0,  50,  66 ]
gravity :top_right33,    [  50,   0,  50,  33 ]

# Left
gravity :left,           [   0,   0,  50, 100 ]
gravity :left66,         [   0,   0,  66, 100 ]
gravity :left33,         [   0,   0,  33, 100 ]

# Center
gravity :center,         [   0,   0, 100, 100 ]
gravity :center66,       [  17,  17,  66,  66 ]
gravity :center33,       [  33,  33,  33,  33 ]

# Right
gravity :right,          [  50,   0,  50, 100 ]
gravity :right66,        [  34,   0,  66, 100 ]
gravity :right33,        [  67,   0,  33, 100 ]

# Bottom left
gravity :bottom_left,    [   0,  50,  50,  50 ]
gravity :bottom_left66,  [   0,  34,  50,  66 ]
gravity :bottom_left33,  [   0,  67,  50,  33 ]

# Bottom
gravity :bottom,         [   0,  50, 100,  50 ]
gravity :bottom66,       [   0,  34, 100,  66 ]
gravity :bottom33,       [   0,  67, 100,  33 ]

# Bottom right
gravity :bottom_right,   [  50,  50,  50,  50 ]
gravity :bottom_right66, [  50,  34,  50,  66 ]
gravity :bottom_right33, [  50,  67,  50,  33 ]
 
  #Gimp
gravity :gimp_image,     [  10,   0,  80, 100 ]
gravity :gimp_toolbox,   [   0,   0,  10, 100 ]
gravity :gimp_dock,      [  90,   0,  10, 100 ]

  # Scratchpad
gravity :scratchpad,     [  20, 50, 60, 45 ]

  # Pidgin
gravity :pidgin,         [   0, 50, 25, 100 ]
# }}} 


# Grabs {{{
# Host specific
modkey   = "W"
gravkeys = [ "1", "2", "3", "4", "5", "6", "7", "8", "9" ]

# Views and screens
(1..9).each do |i|
  grab modkey + "-#{i}",   "ViewSwitch#{i}".to_sym
  grab modkey + "-S-#{i}", "ViewJump#{i}".to_sym
end

# Windows
grab modkey + "-q", [ :top_left  ]
grab modkey + "-w", [ :top  ]
grab modkey + "-e", [ :top_right ]
grab modkey + "-a", [ :left ]
grab modkey + "-s", [ :center ]
grab modkey + "-d", [ :right ]
grab modkey + "-z", [ :bottom_left ]
grab modkey + "-x", [ :bottom ]
grab modkey + "-v", [ :bottom_right ]
grab modkey + "-B1",      :WindowMove
grab modkey + "-B3",      :WindowResize
grab modkey + "-f",       :WindowFloat
grab modkey + "-C-b",     :WindowBorderless
grab modkey + "-S-space", :WindowFull
grab modkey + "-s",       :WindowStick
grab modkey + "-r",       :WindowRaise
grab modkey + "-l",       :WindowLower
grab modkey + "-Left",    :WindowLeft
grab modkey + "-Down",    :WindowDown
grab modkey + "-Up",      :WindowUp
grab modkey + "-Right",   :WindowRight
grab modkey + "-S-c",     :WindowKill
grab modkey + "-h", lambda { |c| c.retag }
grab "A-Tab" do
   clients = Subtlext::Client.visible
    
   clients.last.instance_eval do
   focus
   raise
  end
end
                      
grab "A-S-Tab" do 
  clients = Subtlext::Client.visible
                         
  clients.first.instance_eval do                                                 
  lower                                                                        
  end
 clients.first.instance_eval do
 focus
end                                                                            
end

# Reload/restart
grab modkey + "-C-q",     :SubtleQuit
grab modkey + "-C-r",     :SubtleReload
grab modkey + "-C-A-r",   :SubtleRestart

# Multimedia keys
grab "XF86AudioMute",        :VolumeToggle
grab "XF86AudioRaiseVolume", "dvol.sh -i 2"
grab "XF86AudioLowerVolume", "dvol.sh -d 2"
grab "XF86AudioPlay",        :MpdToggle
grab "XF86AudioStop",        :MpdStop
grab "XF86AudioNext",        :MpdNext
grab "XF86AudioPrev",        :MpdPrevious

# Programs
grab modkey + "-Return", "xterm"
grab modkey + "-c", "firefox-developer-edition"
grab modkey + "-p", "interrobang"
grab modkey + "-t", "xterm -name ranger -e ranger"
grab modkey + "-m", "xterm -name mutt -e mutt"
grab modkey + "-n", "xterm -name ncmpcpp -e ncmpcpp"
grab modkey + "-Escape", "pygtk-shutdown-systemd"
grab modkey + "-f", "xterm -name freenas -e 'ssh -X -p 45002 paul@192.168.1.12'"
grab "W-y" do
  Subtle::Contrib::Launcher.run
end

grab "W-S-s" do  
  if (c = Subtlext::Client.first("scratchpad"))
    c.toggle_stick
    c.focus
    c.raise
  elsif (c = Subtlext::Client.spawn("xterm -name scratchpad"))
    c.tags  = []
    c.flags = [ :stick ]
 end
end

# Tags   {{{  
tag "u" do
  match    instance: "xterm|urxvtc|urxvt|terminal|mutt|freenas|ncmpcpp"
  gravity  :center
  resize   true
end

tag "S" do
  match "navigator|(google\-)?chrom[eium]|vlc"
  gravity :center
end

tag "t" do
  match  "[g]?vim|gedit|pluma|mousepad"
  resize true
end

tag "b" do
  match    "nautilus|thunar|ranger|spacefm"
end

tag "l"  do
  match   "mplayer"
  float true
end

tag "e" do
  match   "calibre"
  gravity :center
end

tag "float" do
  match :name => "Copying*";
  match :name => "Moving*";
  match :name => "File*";
  match "smplayer";
  float true
end

tag "scratchpad" do
  match :instance => "scratchpad"
  gravity :scratchpad
  urgent false
  stick true
end

tag "stick" do
  match  "dialog|subtly|python|gtk.rb|display|pychrom|skype|xev|evince|exe|<unknown>|plugin-container"
  stick  true
  float  true
end

tag "urgent" do
  stick  true
  urgent true
  float  true
end

tag "dialogs" do
  match  "sun-awt-X11-XDialogPeer"
  match type: [ :dialog, :splash ]
  stick true
end

tag "terms" do
  match    "terms"
  gravity  :center
end

tag "gimp_image" do
  match    role: "gimp-image-window"
  gravity  :gimp_image
end

tag "gimp_toolbox" do
  match    role: "gimp-toolbox$"
  gravity  :gimp_toolbox
end

tag "gimp_dock" do
  match    role: "gimp-dock"
  gravity  :gimp_dock
end

tag "gimp_scum" do
  match role: "gimp-.*|screenshot"
end
# }} }

# View s  {{{ 
net       = "S"
terms     = "u"
file      = "b"
media     = "t"
edit      = "l"
stuff     = "e"
icons     = false

iconpath = "#{ENV["HOME"]}/.icons/subtle"

space = {
  :net     => Subtlext::Icon.new("#{iconpath}/invader1.xbm"),
  :terms   => Subtlext::Icon.new("#{iconpath}/invader2.xbm"),
  :file    => Subtlext::Icon.new("#{iconpath}/invader3.xbm"),
#  :im      => Subtlext::Icon.new("#{iconpath}/balloon.xbm"),
  :media   => Subtlext::Icon.new("#{iconpath}/movie.xbm"),
  :edit    => Subtlext::Icon.new("#{iconpath}/binder.xbm"),
  :stuff   => Subtlext::Icon.new("#{iconpath}/ghost.xbm"),
  :gimp    => Subtlext::Icon.new("#{iconpath}/pencil.xbm"),
  :libre   => Subtlext::Icon.new("#{iconpath}/mouse.xbm")
}

view "S" do
  match     net
  icon_only false
end

view "u" do
  match     terms
  icon_only false
end

view "b" do
  match     file
  icon_only false
end

view "t" do
  match   media
  icon_only false
end

view "l" do
  match   edit
  icon_only false
end

view "e" do
  match   stuff
  icon_only false
end

on :start do
   Subtlext::Client.spawn "setxkbmap gb"
end

on :start do
   Subtlext::Client.spawn "setxkbmap -option terminate:ctrl_alt_bksp"
end

sublet :clock2 do
  time_format "%H:%M"
  date_format "%d/%m/%y"
  time_color "#4a7b6c"
  date_color "#4a7b6c"
end  
  
sublet :battery do
  color_text true
  colors 10 => "#FF0000", 20 => "#399bff", 100 => "#33cc00"
  path "/sys/class/power_supply/BAT0"
end

sublet :mpd do
  not_running_text "No Music :("
  show_colors true
  pause_text "Paused"
  stop_text "Stopped"
  note_color "#00ff00"
  show_icons false
  format_string   "%note% %artist% - %title%"
  artist_color "#0066cc"
  album_color "#ccff33"
  title_color "#cc0033"
  track_color "#33ff33"
  id_color "#ccff33"
  pause_color "#00ff00"
  stop_color "#00ff00"
end 
# }}}
