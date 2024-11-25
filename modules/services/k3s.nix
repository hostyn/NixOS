{
  config,
  lib,
  ...
}: let
  cfg = config.custom.services.k3s;
in {
  options.custom.services.k3s = {
    enable = lib.mkEnableOption "k3s";
  };

  config = lib.mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [6443 2379 2380];
    networking.firewall.allowedUDPPorts = [8472];

    # You will need to manually add kube-vip https://kube-vip.io/docs/usage/k3s/
    services.k3s = {
      enable = true;
      role = "server";
      token = "awQ4VyY6bdJUGj1l";
      clusterInit = true;
      # serverAddr = "https://192.168.0.200:6443";
      extraFlags = toString [
        "--write-kubeconfig-mode \"0644\""
        "--disable servicelb"
        "--disable traefik"
        "--disable local-storage"
        "--tls-san 192.168.0.200"
      ];
    };
  };
}
