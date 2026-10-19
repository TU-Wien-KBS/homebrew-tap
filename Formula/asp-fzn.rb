class AspFzn < Formula
  desc "Enables solving ASP programs via FlatZinc solvers"
  homepage "https://kr.tuwien.ac.at/systems/asp-fzn/"
  url "https://gitlab.tuwien.ac.at/kbs/BAI/asp-fzn/-/archive/v0.3.2/asp-fzn-v0.3.2.tar.gz"
  sha256 "c66ce50a926f94b30e037e9c51566acb828a027a21f3a78e559da8750d5ff7ee"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/TU-Wien-KBS/homebrew-tap/releases/download/asp-fzn-0.3.2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "e822a4ab6b08c64fcb04c322a1cc32e19c72934729469dfae04c07c9f7eb0c60"
    sha256 cellar: :any,                 x86_64_linux: "7e39aea4098e121c14a526998d26808222dc560a4a5257c2ecd49983c81fb4b0"
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
