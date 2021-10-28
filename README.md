# arch-sway
minimal arch linux sway installation:

firstly: <br />
Download archiso from https://archlinux.org/download/ and Install with minimal option

then: <br />
git clone https://github.com/mumin16/arch-sway.git <br />
cd arch-sway  <br />
bash sway-install.sh

Android Studio problems:  <br />
/etc/profile  <br />
export _JAVA_AWT_WM_NONREPARENTING=1  <br />

Policykit - The rule<br />

Create the file /etc/polkit-1/rules.d/10-udisks2.rules with the following content<br />

polkit.addRule(function(action, subject) {<br />
  var YES = polkit.Result.YES;<br />
  var permission = {<br />
    // required for udisks1:<br />
    // "org.freedesktop.udisks.filesystem-mount": YES,<br />
    // "org.freedesktop.udisks.luks-unlock": YES,<br />
    // "org.freedesktop.udisks.drive-eject": YES,<br />
    // "org.freedesktop.udisks.drive-detach": YES,<br />
    // required for udisks2:<br />
    "org.freedesktop.udisks2.filesystem-mount": YES,<br />
    "org.freedesktop.udisks2.filesystem-mount-system": YES,<br />
    "org.freedesktop.udisks2.encrypted-unlock": YES,<br />
    "org.freedesktop.udisks2.encrypted-unlock-system": YES,<br />
    "org.freedesktop.udisks2.eject-media": YES,<br />
    "org.freedesktop.udisks2.eject-media-system": YES,<br />
    "org.freedesktop.udisks2.power-off-drive": YES,<br />
    "org.freedesktop.udisks2.power-off-drive-system": YES,<br />
    // required for udisks2 if using udiskie from another seat (e.g. systemd):<br />
    "org.freedesktop.udisks2.filesystem-mount-other-seat": YES,<br />
    "org.freedesktop.udisks2.filesystem-unmount-others": YES,<br />
    "org.freedesktop.udisks2.encrypted-unlock-other-seat": YES,<br />
    "org.freedesktop.udisks2.eject-media-other-seat": YES,<br />
    "org.freedesktop.udisks2.power-off-drive-other-seat": YES<br />
  };<br />
  if (subject.isInGroup("storage")) {<br />
    return permission[action.id];<br />
  }<br />
});<br />

If you're wondering how I got the list of permission, do a $ pkaction. It goes without saying that your user needs to be in the storage group, for this to work. The above rule just says, give mount/unmount/eject permissions to those processes from a subject($USER), who is a member of the storage group.<br />

$ groups # gives a list<br />
$ sudo usermod -a -G storage ronin # adds ronin to storage group<br />
