class AspFzn < Formula
  desc "Enables solving ASP programs via FlatZinc solvers"
  homepage "https://kr.tuwien.ac.at/systems/asp-fzn/"
  url "https://gitlab.tuwien.ac.at/kbs/BAI/asp-fzn/-/archive/v0.3.2/asp-fzn-v0.3.2.tar.gz"
  sha256 "c66ce50a926f94b30e037e9c51566acb828a027a21f3a78e559da8750d5ff7ee"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/TU-Wien-KBS/homebrew-tap/releases/download/asp-fzn-0.3.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "d66e0474545a4ac54061002e0a39c83d817c03828e09a1257790df757cc3da0c"
    sha256 cellar: :any,                 x86_64_linux: "6b81a31c5bf96a2a6245116f27b56a9a5a5c3516f6e36f302488c1a423b3426b"
  end

  depends_on "rust" => :build
  depends_on "clingo"
  depends_on "minizinc"
  depends_on "or-tools"

  def fetch
    cd "asp-fzn-cli" do
      system "cargo", "fetch", *std_cargo_fetch_args
    end
  end

  def install
    cd "asp-fzn-cli" do
      system "cargo", "install", *std_cargo_args
    end
  end

  test do
    (testpath/"test.lp").write <<~EOS
      a | b.
      b.
      :- not a.
    EOS

    output = shell_output("#{bin}/asp-fzn -s cp-sat test.lp")
    assert_match "=====UNSATISFIABLE=====", output
  end
end
