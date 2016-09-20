defmodule EncryptionTest do
  use ExUnit.Case
  doctest Encryption

  describe "encrypt when key is present" do
    setup do
      File.write!(Path.join(Mix.Project.manifest_path, "priv/keys/user-1.key"), "1")
      on_exit fn -> File.rm!(Path.join(Mix.Project.manifest_path, "priv/keys/user-1.key")) end
    end

    test "returns result" do
      assert Encryption.encrypt("2") == "21"
    end

    test "returns error for non-binary data" do
      assert Encryption.encrypt(2) == "Key and Data should be binary and present"
    end
  end

  test "returns error when key not present" do
    assert Encryption.encrypt(2) == "Key should be present"
  end
end
