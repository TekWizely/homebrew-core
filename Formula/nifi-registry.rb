class NifiRegistry < Formula
  desc "Centralized storage & management of NiFi/MiNiFi shared resources"
  homepage "https://nifi.apache.org/registry"
  url "https://www.apache.org/dyn/closer.lua?path=/nifi/1.18.0/nifi-registry-1.18.0-bin.zip"
  mirror "https://archive.apache.org/dist/nifi/1.18.0/nifi-registry-1.18.0-bin.zip"
  sha256 "d58daed0ca00bba531735879b9afa9e2c668d53f43518e17f21e1d7beba87d76"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "7d620dda95d9c14aea94e914e8ea02f28e8bbfa9fe8bbcff6a5ee85f66e25071"
  end

  depends_on "openjdk"

  def install
    libexec.install Dir["*"]
    rm Dir[libexec/"bin/*.bat"]

    bin.install libexec/"bin/nifi-registry.sh" => "nifi-registry"
    bin.env_script_all_files libexec/"bin/",
                             Language::Java.overridable_java_home_env.merge(NIFI_REGISTRY_HOME: libexec)
  end

  test do
    output = shell_output("#{bin}/nifi-registry status")
    assert_match "Apache NiFi Registry is not running", output
  end
end
