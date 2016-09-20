defmodule Encryption do
  @module_doc "Helps with Public Key Encryption"

  @doc """
  Public Interface method for Encryption

  Accepts data to be encrypted

  Based on client attributes, gets the key from disk to be used in encryption

  Check tests for usage, data restrictions and result when key is present/absent
  """
  def encrypt(data) do
    key = case File.read(Path.join(Application.get_env(:encryption, :keys_path), "user-1.key")) do
      {:ok, contents} -> contents
      {:error, reason} -> nil
    end
    encrypt(key, data)
  end


  defp encrypt(key, data) when is_nil(key), do: "Key should be present"
  defp encrypt(key, data) when is_binary(key) and is_binary(data) do
    Process.sleep(2000)
    data <> key
  end
  defp encrypt(key, data), do: "Key and Data should be binary and present"
end
