defmodule Encryption.ServerTest do
  use ExUnit.Case

  describe "single process" do
    test "result" do
      {:ok, pid} = Encryption.Server.start_link
      assert Encryption.Server.encrypt(pid, "2") == "21"
    end
  end

  describe "multiple processes" do
    test "result" do
      1..5
        |> Enum.map(fn(_x) -> {:ok, pid} = Encryption.Server.start_link; pid; end)
        |> Enum.map(fn(pid) ->
          assert Encryption.Server.encrypt(pid, "2") == "21" # Blocking call, serailises responses
        end)
    end

    test "tasks" do
      r = 1..5
        |> Enum.map(fn(_x) -> {:ok, pid} = Encryption.Server.start_link; pid; end)
        |> Enum.map(&Task.async(fn ->
          Encryption.Server.encrypt(&1, "2") # Non-Blocking calls, results collected by Task await
        end))
        |> Enum.map(&Task.await/1)

      assert r == (1..5 |> Enum.map(fn(x) -> "21" end))
    end
  end
end
