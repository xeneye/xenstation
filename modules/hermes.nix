{...}: {
  services.hermes-agent = {
    enable = true;

    addToSystemPackages = true;

    settings = {
      model = {
        provider = "custom";
        base_url = "http://127.0.0.1:11434/v1";
        default = "edtorre/gemma4:12b-agent-20gbGPU";
      };

      toolsets = [
        "all"
      ];
    };
  };
}
