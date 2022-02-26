defmodule StateServerTest do
  use ExUnit.Case

  defmodule MyServer do
    use StateServer

    definit do
      fn(params) -> params end
    end

    defcall :get_name do
      fn state, _ -> state[:name] end
    end

    defcast :set_name do
      fn state, name ->
        Keyword.put(state, :name, name)
      end
    end
  end

  test "defcall" do
    {:ok, pid} = MyServer.start_link(name: "Alex", age: 26)
    assert MyServer.get_name(pid) == "Alex"
    GenServer.stop(pid)
  end

  test "defcast" do
    {:ok, pid} = MyServer.start_link(name: "Alex", age: 26)
    MyServer.set_name(pid, "Alexis")
    assert MyServer.get_name(pid) == "Alexis"
    GenServer.stop(pid)
  end
end
