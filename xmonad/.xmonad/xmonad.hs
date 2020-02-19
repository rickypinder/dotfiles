import XMonad
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.Cross
import XMonad.Layout.BinarySpacePartition
import XMonad.Layout.Accordion 
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Tabbed
import XMonad.Layout.SimpleFloat
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Util.Run
import XMonad.Hooks.SetWMName
import qualified Data.Map as M

myLayoutHook = avoidStruts $
               spacingRaw True (Border 0 5 5 5) True (Border 5 5 5 5) True  $
               ResizableTall 1 (3/100) (1/2) [] ||| noBorders Full ||| simpleCross ||| emptyBSP ||| Accordion ||| ThreeColMid 1 (3/100) (1/2)

brightnessUpKey   = 0x1008FF02
brightnessDownKey = 0x1008FF03
volumeUpKey       = 0x1008FF13
volumeDownKey     = 0x1008FF11
volumeMuteKey     = 0x1008FF12
microphoneMuteKey = 0x1008FFB2

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList
        [ ((modm, xK_z), sendMessage MirrorShrink)
        , ((modm, xK_a), sendMessage MirrorExpand)
        , ((modm, xK_p), spawn "rofi -show run")
        , ((0, brightnessUpKey), spawn "xbacklight -inc 5")
        , ((0, brightnessDownKey), spawn "xbacklight -dec 5")
        , ((0, volumeUpKey), spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%")
        , ((0, volumeDownKey), spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%")
        , ((0, volumeMuteKey), spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
        , ((0, microphoneMuteKey), spawn "pactl set-source-mute 1 toggle")
        ]

main = do
    xmproc <- spawnPipe "xmobar ~/.xmonad/xmobarrc"
    unsafeSpawn "$HOME/.fehbg"
    spawn "setxkbmap -layout gb -option ctrl:nocaps"
    xmonad $ docks def
          { modMask = mod4Mask
          , startupHook = setWMName "LG3D"
          , terminal = "urxvt"
          , borderWidth = 3
          , focusedBorderColor = "#03403F"
          , layoutHook = myLayoutHook
          , logHook = dynamicLogWithPP $ def { ppOutput = hPutStrLn xmproc }
          , keys = myKeys <+> keys def
          } 
