defmodule EncryptionTest do
  use ExUnit.Case
  doctest Encryption

  describe "encrypt when key is present" do
    setup do
      assert File.exists?(Application.get_env(:encryption, :master_key_path))
      :ok
    end

    test "returns result" do
      assert Encryption.encrypt("2") == "21"
    end

    test "returns error for non-binary data" do
      assert Encryption.encrypt(2) == "Key and Data should be binary and present"
    end
  end

  describe "encrypt when key is not present" do
    setup do
      orig_path = Application.get_env(:encryption, :master_key_path)
      Application.put_env(:encryption, :master_key_path, Path.join(orig_path, "not_found"))
      on_exit(fn -> Application.put_env(:encryption, :master_key_path, orig_path) end)
      :ok
    end

    test "returns error message" do
      assert Encryption.encrypt(2) == "Key should be present"
    end
  end
end
