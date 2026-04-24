class GitStack < Formula
  desc "Manage stacks of interdependent Git branches"
  homepage "https://github.com/danroc/git-stack"
  url "https://github.com/danroc/git-stack/releases/download/v0.1.0/git-stack-0.1.0.tar.gz"
  sha256 "b19400186e3070be7d458401b92d544c12a55d37267513ddccd4a5fbd88c34bf"
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
