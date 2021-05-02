self: super: 
{
  pomodoro-new = super.gnome3.pomodoro.overrideAttrs (oldAttrs: rec {
    name = "gnome-shell-pomodoro";
    version = "0.19.1";

    src = self.fetchFromGitHub {
      owner = "codito";
      repo = "gnome-pomodoro";
      rev = "99017677cca7b252e58d07f09af5d2137efd34e5";
      sha256 = "0i7f2np52w2srdjg2a0a3qn53nzfg71y27zrs8bzgs7k9i0vlvla";
    };
  });
}
