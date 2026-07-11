class Trail < Formula
  desc "Local-first operation database for code and text worktrees."
  homepage "https://github.com/crabbuild/trail"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/crabbuild/trail/releases/download/v0.1.0/trail-aarch64-apple-darwin.tar.xz"
      sha256 "a26e539b0116d5b9f9958b6b097fe7f25efd1acf9a76104278c556778bd7dfca"
    end
    if Hardware::CPU.intel?
      url "https://github.com/crabbuild/trail/releases/download/v0.1.0/trail-x86_64-apple-darwin.tar.xz"
      sha256 "617d0857e8723f80f885deb0f85fda5ee88516c5fca47bd523137f4b9847ca06"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/crabbuild/trail/releases/download/v0.1.0/trail-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "df33a4ff3e7af1c42c8c2b30c4ce7d5b67ec42bac9129c6cb1677bfda0f8a3bf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/crabbuild/trail/releases/download/v0.1.0/trail-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "877bc3d3f64d4f45606e5c0f8f0f15cc116a6cba7525d20be670687135edf7e8"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
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
