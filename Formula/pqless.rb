class Pqless < Formula
  desc "Browse Parquet files a screenful at a time, like less"
  homepage "https://github.com/danodonovan/pqless"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/danodonovan/pqless/releases/download/v0.2.1/pqless-aarch64-apple-darwin.tar.xz"
      sha256 "54dcb0bde0b068449a6722c88dcf867e46d0aedd3fe0bcb054c3ab471659b1c7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/danodonovan/pqless/releases/download/v0.2.1/pqless-x86_64-apple-darwin.tar.xz"
      sha256 "e745b33ac23468685b3332d6b3c1069c987aea1c59c1d1e74abe06360fbf3fe8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/danodonovan/pqless/releases/download/v0.2.1/pqless-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "61687877371bba2dfdb17532413b23f10876edea14ac69c0e72d9cb2395036f1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/danodonovan/pqless/releases/download/v0.2.1/pqless-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d32c5fa994435fc44858a193becee0abcf0881e3e538d8babc2fa11d2cf5d10b"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

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
      bin.install "pqless"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "pqless"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "pqless"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "pqless"
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
