class Compass < Formula
  desc "Native local-first knowledge graph engine for source code and project artifacts"
  homepage "https://github.com/crabbuild/compass"
  version "0.3.19"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/crabbuild/compass/releases/download/compass-v0.3.19/compass-aarch64-apple-darwin.tar.gz"
      sha256 "c3e0c0eea684ee7098f28add03a1d17343fed11709c0b65bcd7be1d4d89a456b"
    end
    on_intel do
      url "https://github.com/crabbuild/compass/releases/download/compass-v0.3.19/compass-x86_64-apple-darwin.tar.gz"
      sha256 "12627ae5863d99c478e70f922bb2619eb6495ed96016e79a793003520a90283c"
    end
  end

  def install
    bin.install "compass"
    bash_completion.install "completions/compass.bash"
    fish_completion.install "completions/compass.fish"
    zsh_completion.install "completions/_compass"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/compass --version")
  end
end
