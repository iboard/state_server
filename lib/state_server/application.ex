defmodule StateServer.Application do
  @moduledoc ~s"""
  This is a placeholder for now. `StateServer` can be used by directly starting and 
  stopping them. 

  Further versions will implement a persistence layer and supervisor(s).
  """

  use Application

  @impl true
  def start(_type, _args) do
    children = [ ]

    opts = [strategy: :one_for_one, name: StateServer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
