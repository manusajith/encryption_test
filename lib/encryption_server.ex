defmodule Encryption.Server do
  use GenServer

  defmodule State do
    defstruct key: nil
  end

  def start_link do
    GenServer.start_link(__MODULE__, [])
  end

  def encrypt(pid, data) do
    GenServer.call(pid, {:encrypt, data})
  end

  def init([]) do
    {status, value} = File.read(Application.get_env(:encryption, :master_key_path))
    value = case status do
      :ok -> String.trim(value)
      _ -> value
    end
    {status, %State{key: value}}
  end

  def handle_call({:encrypt, data}, _from, state) do
    res = Encryption.encrypt(state.key, data)
    {:reply, res, state}
  end
end
