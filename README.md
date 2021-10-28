# arch-sway
minimal arch linux sway installation:

firstly: <br />
Download archiso from https://archlinux.org/download/ and Install with minimal option

then: <br />
git clone https://github.com/mumin16/arch-sway.git <br />
cd arch-sway  <br />
bash sway-install.sh

Policykit - The rule

Create the file /etc/polkit-1/rules.d/10-udisks2.rules with the following content

polkit.addRule(function(action, subject) {
  var YES = polkit.Result.YES;
  var permission = {
    // required for udisks1:
    // "org.freedesktop.udisks.filesystem-mount": YES,
    // "org.freedesktop.udisks.luks-unlock": YES,
    // "org.freedesktop.udisks.drive-eject": YES,
    // "org.freedesktop.udisks.drive-detach": YES,
    // required for udisks2:
    "org.freedesktop.udisks2.filesystem-mount": YES,
    "org.freedesktop.udisks2.filesystem-mount-system": YES,
    "org.freedesktop.udisks2.encrypted-unlock": YES,
    "org.freedesktop.udisks2.encrypted-unlock-system": YES,
    "org.freedesktop.udisks2.eject-media": YES,
    "org.freedesktop.udisks2.eject-media-system": YES,
    "org.freedesktop.udisks2.power-off-drive": YES,
    "org.freedesktop.udisks2.power-off-drive-system": YES,
    // required for udisks2 if using udiskie from another seat (e.g. systemd):
    "org.freedesktop.udisks2.filesystem-mount-other-seat": YES,
    "org.freedesktop.udisks2.filesystem-unmount-others": YES,
    "org.freedesktop.udisks2.encrypted-unlock-other-seat": YES,
    "org.freedesktop.udisks2.eject-media-other-seat": YES,
    "org.freedesktop.udisks2.power-off-drive-other-seat": YES
  };
  if (subject.isInGroup("storage")) {
    return permission[action.id];
  }
});

If you're wondering how I got the list of permission, do a $ pkaction. It goes without saying that your user needs to be in the storage group, for this to work. The above rule just says, give mount/unmount/eject permissions to those processes from a subject($USER), who is a member of the storage group.

$ groups # gives a list
$ sudo usermod -a -G storage ronin # adds ronin to storage group
