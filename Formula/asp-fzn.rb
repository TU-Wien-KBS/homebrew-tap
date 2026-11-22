class AspFzn < Formula
  desc "Enables solving ASP programs via FlatZinc solvers"
  homepage "https://kr.tuwien.ac.at/systems/asp-fzn/"
  url "https://gitlab.tuwien.ac.at/kbs/BAI/asp-fzn/-/archive/v0.3.4/asp-fzn-v0.3.4.tar.gz"
  sha256 "405b5bfea7277ae0087302470caeeadebd91edbef4406fd8ede1a80f85ab4558"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/TU-Wien-KBS/homebrew-tap/releases/download/asp-fzn-0.3.3"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "a9a3c939e4e4c5d4855b42184c27f4d85a593a8a05c008b4a633b600c678cfc5"
    sha256 cellar: :any,                 x86_64_linux: "a74ca4ff29e0e9c85722c49b27aae282044ab329c8d1e2dc1ea6e5f4e7403f51"
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
