defmodule AdWords.Utils.Logging do
  @moduledoc """
  TODO: Add documentation
  """

  require Logger

  @spec info(String.t()) :: :ok
  def info(message) do
    Logger.info(message)
  end
end
