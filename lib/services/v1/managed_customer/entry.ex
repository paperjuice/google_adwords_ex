defmodule AdWords.Services.V1.ManagedCustomer.Entry do
  @moduledoc false

  alias AdWords.Controller

  @base AdWords.Services.V1

  @doc """
  Add a new customer to the user that authorized the app
  ## Example data:
  %{
    "name" => "AccountName01",
    "currency_code" => "SEK",
    "date_time_zone" => "Europe/London"
  }
  """
  @spec add(map()) :: list()
  def add(conn) do
    Controller.request(
      @base.ManagedCustomer.Add,
      :mutate,
      :managed_customer_service_client,
      conn
    )
  end
end
