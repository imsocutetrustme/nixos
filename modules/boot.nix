{...}:
   {
     flake.nixosModules.boot = { pkgs, ... }: {
       boot.loader.limine = {
         enable = true;
         biosSupport = true;
         biosDevice = "/dev/sda";
       };
       boot.kernelPackages = pkgs.linuxPackages_latest;
     };
 }
