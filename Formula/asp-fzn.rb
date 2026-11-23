class AspFzn < Formula
  desc "Enables solving ASP programs via FlatZinc solvers"
  homepage "https://kr.tuwien.ac.at/systems/asp-fzn/"
  url "https://gitlab.tuwien.ac.at/kbs/BAI/asp-fzn/-/archive/v0.3.5/asp-fzn-v0.3.5.tar.gz"
  sha256 "c564c4b34d684c0420cf89b9eb6058484a65662424e91472992ecfa5681f0c97"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/TU-Wien-KBS/homebrew-tap/releases/download/asp-fzn-0.3.5"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "da757e0904dac0b122c45a81be140dfa992f76ee4a8e63fd66f5f979eb5c5440"
    sha256 cellar: :any,                 x86_64_linux: "36740d2b3d5329a82e623cdf65487d7eba328e67964339989d6cc4516611772d"
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
