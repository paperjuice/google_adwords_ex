defmodule AdWords.Services.V1.Customer.Entry do
  @moduledoc false

  alias AdWords.Controller

  @base AdWords.Services.V1

  @doc """
  Returns details of all the customers directly
  accessible by the user authenticating the call.
  """
  @spec get(map()) :: list()
  def get(conn) do
    Controller.request(
      @base.Customer.Get,
      :getCustomers,
      :customer_service_client,
      conn
    )
  end
end
