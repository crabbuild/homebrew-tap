class Trail < Formula
  desc "Local-first operation database for code and text worktrees."
  homepage "https://github.com/crabbuild/trail"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/crabbuild/trail/releases/download/v0.2.0/trail-aarch64-apple-darwin.tar.xz"
      sha256 "440f24291a6f4086c0bc8cd52279b5f53f927747efa495288404e84efd8031ee"
    end
    if Hardware::CPU.intel?
      url "https://github.com/crabbuild/trail/releases/download/v0.2.0/trail-x86_64-apple-darwin.tar.xz"
      sha256 "5b4ef4b3c967782c7c9fa8382339d31a9bc7c205848de4860348d114766621cf"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/crabbuild/trail/releases/download/v0.2.0/trail-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "88f4856f81ac6119746b20916023d547fdffc3f5140608890e70195982e3b680"
    end
    if Hardware::CPU.intel?
      url "https://github.com/crabbuild/trail/releases/download/v0.2.0/trail-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "21740bf61633dd33c79f9084f64aeecb7a678e39cce9ee284a6e30958044823f"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-pc-windows-gnu": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {}
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "trail"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "trail"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "trail"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "trail"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
