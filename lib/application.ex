defmodule AdWords.Application do
  @moduledoc """
  TODO: Add documentation
  """

  use Application

  alias AdWords.Router

  def start(_types, _args) do
    children = [
      {
        Plug.Cowboy,
        scheme: :http, plug: Router, options: [port: 9999]
      }
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
