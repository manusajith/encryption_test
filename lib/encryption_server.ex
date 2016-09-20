defmodule Encryption.Server do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [])
  end

  def encrypt(pid, data) do
    GenServer.call(pid, {:encrypt, data})
  end

  def handle_call({:encrypt, data}, _from, state) do
    res = Encryption.encrypt(data)
    {:reply, res, state}
  end
end
