*Personal configuration*

*Instructions*
This is for encrypted root, boot, and swap.

Check your drives:
$ lsblk (-f for UUID)

Wipe your drives:
$ wipefs --all /dev/sda1 (do numbers first, then root letter (sda), --force may be neccesary.)
$ sgdisk --zap-all /dev/sda

Set partitions:
$ cgdisk /dev/sda (For UEFI, make the first partition EF00 and at least 128MiB,
                  make a regular partition at least the size of your RAM for swap (keep it as 8300,
                  don't mark as swap, and then the last partition take the entire space up and mark
                  as 8304. The other drives you can partition as you like, my reccomendation is
                  keep it one partition per drive and mount them on /mnt of the mounted root.)

Encrypt partitions:
$ cryptsetup luksFormat /dev/sda2 (and /dev/sda3, and your other drives with their single partitions.)
$ cryptsetup open --type luks /dev/sda2 cryptswap (--allow-discards may be wanted for SSD, name /dev/sda3
                                                   cryptroot.)

Format partitions:
$ mkfs.fat -n uefi -F32 /dev/sda1
$ mkswap -L swap /dev/mapper/cryptswap (make sure to $ swapon /dev/mapper/cryptswap.)
$ mkfs.btrfs -L root /dev/mapper/cryptroot

Mount and create subvolumes:
$ mount -o compress=lzo /dev/mapper/cryptroot /mnt
$ btrfs subvolume create /mnt/@ (Create /mnt/@snapshots, /mnt/@home too. Mount your other btrfs drives and
                                 make one subvolume per drive: $ btrfs subvolume create /mnt/@ssd0)
$ umount /mnt
$ mount -o compress=lzo,subvol=@ /dev/mapper/cryptroot /mnt (compress=noatime,... is wanted for btrfs,
                                                             compress=discard,... in addition to noatime is
                                                             wanted for ssd)
$ mkdir /mnt/{.snapshots,home,etc,var,mnt,boot} (mkdir /mnt/etc/crypto for keys, /mnt/boot/efi for uefi,
                                                 and /mnt/mnt/ssd0 for extra drives too)
$ btrfs subvolume create /mnt/var/log (create /mnt/var/log and /mnt/srv too)
$ chmod 1777 /mnt/var/tmp (btrfs doesn't give it the right permissions)
$ mount -o compress=lzo,subvol=@snapshots /dev/mapper/cryptroot /mnt/.snapshots (extra flags above)
$ mount -o compress=lzo,subvol=@home /dev/mapper/cryptroot /mnt/home
$ mount -o compress=lzo,subvol=@ssd0 /dev/mapper/cryptssd0 /mnt/mnt/ssd0
$ mount /dev/sda1 /mnt/boot/efi

The rest of the installation:
$ dd bs=512 count=4 if=/dev/urandom of=/mnt/etc/crypto/root.key (Create for swap and your other drives too.)
$ chmod 000 /mnt/etc/crypto/*.key
$ cryptsetup luksAddKey /dev/sda3 /mnt/etc/crypto/root.key (Do the same for swap and your other drives with
                                                            their respective keys.)
$ cd /mnt/etc/crypto
$ cpio -o -H newc <<< "root.key" > root.cpio && gzip root.cpio && chmod 000 root.cpio.gz (do swap also.)
$ cd
$ nixos-generate-config --root /mnt
$ nano -w /mnt/etc/nixos/configuration.nix (-w is neccesary because wrapping)

See this gitgud link for my configuration: https://gitgud.io/okina/configuration
You will have to change some things, remove some things. Change the UUIDs to your own.
You will have to change hardware-configuration.nix, and optionally port it over to other configs.
As long as you generally follow my configuration, you should be OK.

Once done, just $ nixos-install and reboot (if successful, dont worry about grub message if it says success.)

Helpful resources:
https://nixos.org/nixos/manual/
https://nixos.org/nixos/manual/options.html
https://wiki.archlinux.org/index.php/Dm-crypt/Encrypting_an_entire_system#Btrfs_subvolumes_with_swap
