class GitStack < Formula
  desc "Manage stacks of interdependent Git branches"
  homepage "https://github.com/danroc/git-stack"
  url "https://github.com/danroc/git-stack/releases/download/v0.2.1/git-stack-0.2.1.tar.gz"
  sha256 "bd6737e9e41cc28220cd93430f2eaa6c5c8daa09b6c9cd5cffb1146cc79adda3"
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
