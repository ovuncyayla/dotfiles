import XMonad
import XMonad.Config.Desktop
import XMonad.Config.Kde
import qualified Data.Map as M

main =
  xmonad
     desktopConfig
     { terminal = "st",
        modMask = mod4Mask
        , keys = myKeys <+> keys desktopConfig 
        --, manageHook = myManageHook
      }     

myKeys (XConfig {modMask = modm}) = M.fromList
    [
        ((modm .|. shiftMask,  xK_q ), spawn "qdbus org.kde.ksmserver /KSMServer org.kde.KSMServerInterface.logout -1 -1 -1"),
        --((modm .|. shiftMask,  xK_c ), spawn "qdbus org.kde.ksmserver /KSMServer org.kde.KSMServerInterface.logout -1 -1 -1"),
        ((modm .|. shiftMask,  xK_space ), spawn "qdbus org.kde.plasmashell /PlasmaShell evaluateScript 'p = panelById(panelIds[0]); p.height = 22 - p.height;'")
    ]

myManageHook = composeAll
    [
        className =? "plasmashell"        --> doFloat
    ]
