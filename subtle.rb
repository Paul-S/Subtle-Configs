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

  Subtle::Contrib::Selector.font  = "xft:Days-9:antialias=true:hinting=true:hintstyle=medium"
  Subtle::Contrib::Launcher.fonts = [
    "xft:Arial:bold:pixelsize=40",
    "xft:Arial:bold:pixelsize=10"
  ]

  Subtle::Contrib::Launcher.browser_screen_num = 0
rescue LoadError
end # }}}

# Options {{{
set :step,      5
set :snap,      10
set :gravity,   :center
set :urgent,    false
set :resize,    false
set :tiling,    false
# }}}

# Screens {{{
screen 1 do
arch = Subtlext::Icon.new("/home/paul/.icons/subtle/subtle1.xbm")
  top     [ :spacer, :mpd, :weather_mod, :spacer, arch ]
  bottom [ :views, :title, :spacer, :textfile, :spacer, :cpu, :separator, :battery, :separator, :nettraffic, :separator, :clock, :separator, :notify, :tray ]
end

# }}}

# Styles {{{
style :all do
  padding    1, 4, 1, 4
  background "#EBEBEB"
  font       "xft:Droid Sans-12:bold:antialias=true:hinting=true:hintstyle=medium"
  #font       "-*-tamsyn-medium-r-normal-*-10-*-*-*-*-*-*-*"
end

style :title do
  foreground "#000000"
end

style :views do
  foreground "#b22020"
  icon       "#c2c2c2"

  style :focus do
    foreground    "#b22020"
    icon          "#000000"
    border_bottom "#000000", 2
  end

  style :occupied do
    icon          "#808080"
    foreground    "#95b2cc"
    border_bottom "#808080", 2
  end

  style :urgent do
    foreground "#ffffff"
    icon       "#c0bd5c"
  end

  style :visible do
    padding_top 2
   # border_top  "#ff006a", 2
  end
end

style :sublets do
  style :clock do
       foreground "#657b83" 
       icon       "#657b83" 
  end
  style :tasks do
       foreground "#ff9800"
  end
  style :cpu do
       foreground "#657b83"
  end     
  style :weather_mod do
       foreground "#657b83"
       background "#ebebeb"
  end  
  style :betternotify do
       foreground "#ff006a"
       background "#ebebeb"
  end        
       foreground "#657b83"
       background "#ebebeb"
end

style :separator do
  foreground "#073642"
  separator  " "
end

style :clients do
 # active   "#7c7c72", 2
  active "#657b83", 1
 # inactive "#494948", 2
  inactive "#002b36", 1
  margin   1
end

style :subtle do
  panel      "#ebebeb"
  padding    0, 0, 0, 0
  #background "#595959"
  stipple    "#595959"
end # }}}

# Gravities {{{
  # Full
gravity :full,           [   0,   0, 100, 100 ]
  # Top left
gravity :top_left,       [ 100,   0,  50,  50 ]
gravity :top_left66,     [ 100,   0,  50,  66 ]
gravity :top_left33,     [ 100,   0,  50,  34 ]

  # Top
gravity :top,            [ 100,   0, 100,  50 ]
gravity :top66,          [ 100,   0, 100,  66 ]
gravity :top33,          [ 100,   0, 100,  34 ]

  # Top right
gravity :top_right,      [ 100,  50,  50,  50 ]
gravity :top_right66,    [ 100,  50,  50,  66 ]
gravity :top_right33,    [ 100,  50,  50,  34 ]

  # Left
gravity :left,           [   0,  50,  50, 100 ]
gravity :left66,         [   0,  50,  50,  66 ]
gravity :left33,         [   0,  50,  25,  34 ]

  # Center
gravity :center,         [   0,   0, 100, 100 ]
gravity :center66,       [   0,   0, 100,  66 ]
gravity :center33,       [   0,   0, 100,  34 ]

  # Right
gravity :right,          [  50,   0,  50, 100 ]
gravity :right66,        [  50,   0,  50,  66 ]
gravity :right33,        [  50,   0,  50,  34 ]

  # Bottom left
gravity :bottom_left,    [   0,  50,  50,  50 ]
gravity :bottom_left66,  [   0,  50,  50,  66 ]
gravity :bottom_left33,  [   0,  50,  50,  34 ]

  # Bottom
gravity :bottom,         [  50,   0, 100, 100 ]
gravity :bottom66,       [  50,   0, 100,  66 ]
gravity :bottom33,       [  50,   0, 100,  34 ]

  # Bottom right
gravity :bottom_right,   [   0,  50,  50,  50 ]
gravity :bottom_right66, [   0,  50,  50,  66 ]
gravity :bottom_right33, [   0,  50,  50,  34 ]

 #Gimp
gravity :gimp_image,     [   0,   0,  83, 100 ]
gravity :gimp_toolbox,   [  83,   0,  17,  30 ]
gravity :gimp_dock,      [  83,  30,  17,  70 ]

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
grab modkey + "-q", [ :top_left,     :top_left66,     :top_left33     ]
grab modkey + "-w", [ :top,          :top66,          :top33          ]
grab modkey + "-e", [ :top_right,    :top_right66,    :top_right33    ]
grab modkey + "-a", [ :left,         :left66,         :left33         ]
grab modkey + "-s", [ :center,       :center66,       :center33       ]
grab modkey + "-d", [ :right,        :right66,        :right33        ]
grab modkey + "-y", [ :bottom_left,  :bottom_left66,  :bottom_left33  ]
#grab modkey + "-x", [ :bottom,       :bottom66,       :bottom33       ]
grab modkey + "-B1",      :WindowMove
grab modkey + "-B3",      :WindowResize
grab modkey + "-S-f",     :WindowFloat
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
grab "XF86AudioRaiseVolume", :VolumeRaise
grab "XF86AudioLowerVolume", :VolumeLower
grab "XF86AudioPlay",        :MpdToggle
grab "XF86AudioStop",        :MpdStop
grab "XF86AudioNext",        :MpdNext
grab "XF86AudioPrev",        :MpdPrevious

# Programs
grab modkey + "-Return", "urxvt"
grab modkey + "-c", "chromium"
grab modkey + "-f", "firefox"
grab modkey + "-t", "thunar"
grab modkey + "-p", "/home/paul/scripts/launcher"
grab modkey + "-C-d", "/home/paul/scripts/todo1"
grab modkey + "-C-t", "urxvt -name ranger -e ranger"
grab modkey + "-C-m", "urxvt -name mutt -e mutt"
grab modkey + "-C-n", "urxvt -name ncmpcpp -e ncmpcpp"
grab modkey + "-Escape", "/home/paul/scripts/shutdown-menu.sh"
grab modkey + "-C-f", "urxvt -name finch -e finch"
# Contrib
grab "W-x" do
  Subtle::Contrib::Launcher.run
end

grab "W-z" do
  Subtle::Contrib::Selector.run
end

# Scratchpad
grab "W-S-s" do
  if (c = Subtlext::Client.first("scratchpad"))
    c.toggle_stick
    c.focus
  elsif (c = Subtlext::Subtle.spawn("urxvt -name scratchpad"))
    c.tags  = []
    c.flags = [ :stick ]
  end
end

# Tags {{{
tag "terms" do
  match    instance: "xterm|urxvtc|urxvt|terminali|mutt"
 # exclude  instance: "scratchpad"
  gravity  :center
  resize   true
end

tag "net" do
  match "navigator|(google\-)?chrom[e|ium]"
  gravity :center
end

tag "edit" do
  match  "[g]?vim|gedit"
  resize true
end

tag "file" do
  match    "thunar|ranger"
end

tag "im" do
  match    "pidgin|finch"
  gravity :pidgin
end

tag "media" do
  match   "mplayer|ncmpcpp|vlc"
  float true
  #gravity :top
  #stick   true
  #urgent  true
end

tag "stuff" do
  match   "calibre"
  gravity :center
end

tag "float" do
  match :name => "Copying*";
  match :name => "Moving*";
  match :name => "File*";
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
# }}}

# Views {{{
net       = "net"
terms     = "term"
file      = "file"
im        = "im"
media     = "media"
edit      = "edit"
stuff     = "stuff"
gimp      = "gimp"
libre     = "libre"
icons     = true

iconpath = "#{ENV["HOME"]}/.icons/subtle"

space = {
  :net     => Subtlext::Icon.new("#{iconpath}/invader1.xbm"),
  :terms   => Subtlext::Icon.new("#{iconpath}/invader2.xbm"),
  :file    => Subtlext::Icon.new("#{iconpath}/invader3.xbm"),
  :im      => Subtlext::Icon.new("#{iconpath}/balloon.xbm"),
  :media   => Subtlext::Icon.new("#{iconpath}/movie.xbm"),
  :edit    => Subtlext::Icon.new("#{iconpath}/binder.xbm"),
  :stuff   => Subtlext::Icon.new("#{iconpath}/ghost.xbm"),
  :gimp    => Subtlext::Icon.new("#{iconpath}/pencil.xbm"),
  :libre   => Subtlext::Icon.new("#{iconpath}/mouse.xbm")
}

view "net" do
  match     net
  #icon      "#{iconpath}/world.xbm"
  icon      Subtlext::Icon.new("#{iconpath}/invader1.xbm")
  icon_only icons
end

view "terms" do
  match     terms
  #icon      "#{iconpath}/terminal.xbm"
  icon      Subtlext::Icon.new("#{iconpath}/invader2.xbm")
  icon_only icons
end

view "file" do
  match     file
  #icon      "#{iconpath}/quote.xbm"
  icon      Subtlext::Icon.new("#{iconpath}/invader3.xbm")
  icon_only icons
end

view "im" do
  match   im
  icon     Subtlext::Icon.new("#{iconpath}/balloon.xbm")
  icon_only icons
end

view "media" do
  match   media
  icon     Subtlext::Icon.new("#{iconpath}/movie.xbm")
  icon_only icons
end

view "edit" do
  match   edit
  icon     Subtlext::Icon.new("#{iconpath}/binder.xbm")
  icon_only icons
end

view "stuff" do
  match   stuff
  icon     Subtlext::Icon.new("#{iconpath}/ghost.xbm")
  icon_only icons
end

view "gimp" do
  match     "gimp_.*"
  #icon      "#{iconpath}/paint.xbm"
  icon      Subtlext::Icon.new("#{iconpath}/pencil.xbm")
  icon_only icons
end

view "libre" do
  match     libre
  #icon      "#{iconpath}/bug.xbm"
  icon      Subtlext::Icon.new("#{iconpath}/mouse.xbm")
  icon_only icons
end

on :start do
   Subtlext::Subtle.spawn "setxkbmap gb"
end

on :start do
   Subtlext::Subtle.spawn "/home/paul/bin/dunst -t 3"
end

#on :start do
#   Subtlext::Subtle.spawn "nm-applet"
#end

on :start do
   Subtlext::Subtle.spawn "setxkbmap -option terminate:ctrl_alt_bksp"
end

on :start do
   Subtlext::Subtle.spawn "gnome-sound-applet"
end

#on :start do
#   Subtlext::Subtle.spawn "/home/paul/bin/conky -c ~/.conkyrc1 | /home/paul/bin/dzen2 -x '0' -y '0' -w '1366' -h '18' -bg '#073642' -fn 'droid sans:bold:size=8'"
#end

#on :start do
#   Subtlext::Subtle.spawn "pidgin"
#end

# Sublets {{{
#Sublet Colours
#col1 = Subtlext::Color.new("#52d017")                         
#col2 = Subtlext::Color.new("#e67373")                       
#col3 = Subtlext::Color.new("#ffffff") 
#col3 = Subtlext::Color.new("#080808")                      
#col4 = Subtlext::Color.new("#d16587")
#col5 = Subtlext::Color.new("#0D25FD")
#col6 = Subtlext::Color.new("#6699ff")
#col6 = Subtlext::Color.new("#505050")      
#col7 = Subtlext::Color.new("#3bb9ff")  

sublet :clock do
  format_string "%a %b %d, %X"
end

sublet :weather_mod do
  interval 7200
  locale "en"
  units "c"
  location "Swansea"
  day_color "#657b83"
  temp_color "#586e75"
  sep "-"
  temp_suffix 'c'
end  

sublet :notify do
  interval 30                         
  foreground "#808080"
  background "#ebebeb"
  highlight "#FF0000"
end
  
sublet :mpd do
  interval 30
  show_colors true
  foreground "#586e75"
  background "#ebebeb"
  show_icons false
  show_pause true
  def_action "toggle"
  format_string "%note% %artist% - %title%"
  pause_text "mpd paused :("
  artist_color "#586e75"
  title_color "#586e75"
  not_running_text "mpd stopped :("
  album_color "#586e75"
  stop_color "#586e75"
  pause_color "#586e75"
end

sublet :textfile do
  file "/home/paul/downloads/NOTES"
end
  
sublet :temp do
  show_name false
end    
  
sublet :battery do
  colors 10 => "#FF0000", 20 => "#399bff", 100 => "#33cc00"
  path "/sys/class/power_supply/BAT0"
end 
# }}}
