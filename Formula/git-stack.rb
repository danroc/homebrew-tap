class GitStack < Formula
  desc "Manage stacks of interdependent Git branches"
  homepage "https://github.com/danroc/git-stack"
  url "https://github.com/danroc/git-stack/releases/download/v0.1.1/git-stack-0.1.1.tar.gz"
  sha256 "34333a0fecc1bf01faaaeaae9b33b8855213089621c2dab1b62de2b3a18f8f27"
  license "MIT"
  depends_on "go" => :build

  livecheck do
    url "https://github.com/danroc/git-stack/releases/latest"
    regex(/^v?(\d+\.\d+\.\d+)$/i)
  end

  def install
    ldflags = "-s -w -X main.version=#{version}"

    system "go", "build",
      "-ldflags", ldflags,
      "-o", "git-stack",
      "./cmd/git-stack"
    bin.install "git-stack"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/git-stack version")
  end
end
