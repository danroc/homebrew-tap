class GitStack < Formula
  desc "Manage stacks of interdependent Git branches"
  homepage "https://github.com/danroc/git-stack"
  url "https://github.com/danroc/git-stack/releases/download/v0.2.0/git-stack-0.2.0.tar.gz"
  sha256 "19c2f3f497f836d052685cf3034a1656a28f253755549d6d70245aafc25ee227"
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
