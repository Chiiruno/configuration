# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "sd_mod" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/mapper/cryptroot";
      fsType = "bcachefs";
    };

  boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-uuid/3e0248bf-1b64-4c92-968e-f7b373e4e244";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/9b57cb8f-d427-4892-9451-5cac542e39f9";
      fsType = "btrfs";
      options = [ "subvol=@boot" ];
    };

  boot.initrd.luks.devices."cryptboot".device = "/dev/disk/by-uuid/84cdcfe6-c2dd-4f3f-9699-9d9cd2193df7";

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/CF55-5C64";
      fsType = "vfat";
    };

  fileSystems."/mnt/ssd1" =
    { device = "/dev/mapper/cryptssd1";
      fsType = "bcachefs";
    };

  boot.initrd.luks.devices."cryptssd1".device = "/dev/disk/by-uuid/37c55c40-648b-4c4d-b2f4-3d82fbb37e6a";

  fileSystems."/mnt/ssd0" =
    { device = "/dev/mapper/cryptssd0";
      fsType = "bcachefs";
    };

  boot.initrd.luks.devices."cryptssd0".device = "/dev/disk/by-uuid/ea621ba1-a1fa-4d3a-8eb3-178f7aaad84c";

  fileSystems."/mnt/hdd1" =
    { device = "/dev/mapper/crypthdd1";
      fsType = "bcachefs";
    };

  boot.initrd.luks.devices."crypthdd1".device = "/dev/disk/by-uuid/519b45bd-021b-418d-925e-786b83790967";

  fileSystems."/mnt/hdd0" =
    { device = "/dev/mapper/crypthdd0";
      fsType = "bcachefs";
    };

  boot.initrd.luks.devices."crypthdd0".device = "/dev/disk/by-uuid/1990f56a-f2aa-46c0-b451-b6252adcb5fa";

  swapDevices =
    [ { device = "/dev/disk/by-uuid/30108695-39f3-4022-87b4-2b8caa6e63e0"; }
    ];

  nix.maxJobs = lib.mkDefault 16;
}
