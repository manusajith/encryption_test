defmodule Encryption do
  @module_doc "Helps with Public Key Encryption"

  @doc """
  Public Interface method for Encryption

  Accepts data to be encrypted

  Based on client attributes, gets the key from disk to be used in encryption

  Check tests for usage, data restrictions and result when key is present/absent
  """
  def encrypt(data) do
    key = case File.read(Application.get_env(:encryption, :master_key_path)) do
      {:ok, contents} -> String.trim(contents)
      {:error, reason} -> nil
    end
    encrypt(key, data)
  end


  @doc """
  Mostly for internal use but can be used, if key is known

  iex> Encryption.encrypt(nil, "1")
  "Key should be present"

  iex> Encryption.encrypt("2", "1")
  "12"

  iex> Encryption.encrypt("2", 1)
  "Key and Data should be binary and present"

  iex> Encryption.encrypt(2, "1")
  "Key and Data should be binary and present"

  iex> Encryption.encrypt(2, 1)
  "Key and Data should be binary and present"
  """
  def encrypt(key, data) when is_nil(key), do: "Key should be present"
  def encrypt(key, data) when is_binary(key) and is_binary(data) do
    Process.sleep(2000)
    data <> key
  end
  def encrypt(key, data), do: "Key and Data should be binary and present"
end
