class Trail < Formula
  desc "Local-first operation database for code and text worktrees."
  homepage "https://github.com/crabbuild/trail"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/crabbuild/trail/releases/download/v0.3.0/trail-aarch64-apple-darwin.tar.xz"
      sha256 "4d00f6891d2288afaab3f9487f09b7329031c331051dc779ab71a98f94afcf1e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/crabbuild/trail/releases/download/v0.3.0/trail-x86_64-apple-darwin.tar.xz"
      sha256 "0a21556b630a9f823ecfaedb5973c9ebf8f45bfc239d18c984a75d9a0586f278"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/crabbuild/trail/releases/download/v0.3.0/trail-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "038dd883cf48473e808e8ac94702708225fe78f52213ef3efe014debfa92bce1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/crabbuild/trail/releases/download/v0.3.0/trail-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "45624975bdcfa497798d6592053f3cf281fe9c32674fa2d4c294047c997b9908"
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
