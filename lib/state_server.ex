defmodule StateServer do
  @moduledoc """
  The StateServer is a module you can use in your modules to implement a simple GenServer
  without the need of writting all that GenServer's boilerplate.any()

  ### Example

      defmodule MyModule do 
        # make this module a GenServer and import some macros to define calls and casts.
        use StateServer 

        # define the init block of the GenServer.
        init params do
           # this will become the state of our GenServer
           params
        end

        # define the function `set_value(pid, params)` and the corresponding
        # `handle_cast` function.
        defcast set_value do 
          fn(state, [key, value] = _params) -> 
            # modify the state, based on params and return the new state
            Map.put(state, key, value) 
          end
        end

        # define the function `get_value(pid, key, default)` and the corresponding
        # `handle_call` function
        defcall get_value do
          fn(state, [key, default]) ->
            Map.get(state,key) || default
          end
        end
      end


  {:ok, person_pid} = MyModule.start_link(name: "Alex", born: 1997)

  MyModule.get_value(person_pid, :name)
  # "Alex"

  MyModule.set_value(person_pid, [:name, "Alexis"])

  MyModule.state(person_pid)
  # [ name: "Alexis", born: 1997 ]

  """
  defmacro __using__(_opts \\ []) do
    quote do
      use GenServer
      import unquote(__MODULE__)

      def start_link(opts \\ []) do
        GenServer.start_link(__MODULE__, opts)
      end

      def state(pid) do
        GenServer.call(pid, :state)
      end

      def handle_call(:state, _, state), do: {:reply, state, state}
    end
  end

  defmacro definit(_args \\ [], do: blk) do
    quote do
      def init(params) do
        {:ok, unquote(blk).(params)}
      end
    end
  end

  defmacro defcall(fun_name, do: blk) do
    quote do
      def unquote(fun_name)(pid, params \\ nil) do
        GenServer.call(pid, {unquote(fun_name), params})
      end

      def handle_call({unquote(fun_name), params}, _, state) do
        {:reply, unquote(blk).(state, params), state}
      end
    end
  end

  defmacro defcast(fun_name, do: blk) do
    quote do
      def unquote(fun_name)(pid, params \\ nil) do
        GenServer.cast(pid, {unquote(fun_name), params})
      end

      def handle_cast({unquote(fun_name), params}, state) do
        state = unquote(blk).(state, params)
        {:noreply, state}
      end
    end
  end
end
