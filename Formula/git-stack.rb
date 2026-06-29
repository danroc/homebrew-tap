class GitStack < Formula
  desc "Manage stacks of interdependent Git branches"
  homepage "https://github.com/danroc/git-stack"
  url "https://github.com/danroc/git-stack/releases/download/v0.2.1/git-stack-0.2.1.tar.gz"
  sha256 "a4ea1887b9681fb27e60501a12595035d6b42ebe9ab6b31a1c7dbd5bbb714292"
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
