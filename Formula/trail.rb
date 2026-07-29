class Trail < Formula
  desc "Local-first operation database for code and text worktrees."
  homepage "https://github.com/crabbuild/trail"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/crabbuild/trail/releases/download/v0.1.1/trail-aarch64-apple-darwin.tar.xz"
      sha256 "fb83d313700bac2aa6d2a0c35b2dbb02793c33628f3a62c4ab7c4b69904acd19"
    end
    if Hardware::CPU.intel?
      url "https://github.com/crabbuild/trail/releases/download/v0.1.1/trail-x86_64-apple-darwin.tar.xz"
      sha256 "c105b2f1c7fe2c7425c2a44f891c0e70e997cdf71655a6d1f5befe8b67fcbe7b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/crabbuild/trail/releases/download/v0.1.1/trail-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7e6138077ae85dd4961899c0759431b332fbdf6fc8b6d4e528584bd5ef84021b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/crabbuild/trail/releases/download/v0.1.1/trail-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2a14cd49055de1f494f7437b25734ecef26b5ca98bd498f7c2363487fd36279f"
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
