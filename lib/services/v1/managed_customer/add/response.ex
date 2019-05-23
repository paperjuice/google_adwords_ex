defmodule AdWords.Services.V1.ManagedCustomer.Add.Response do
  @moduledoc """
  TODO: Add documentation and arg types and everything
  """

  require AdWords.Types.ManagedCustomerMessage

  alias AdWords.Types.ManagedCustomerMessage, as: MCM
  alias AdWords.Services.Shared

  def handle_successful_response(record, conn) do
    data =
      record
      |> MCM.mutate_response(:rval)
      |> MCM.managed_customer_return_value(:value)
      |> values()

    Shared.add_resp_to_conn(conn, data, 201, "add_managed_customer")
  end

  # ---------------
  # PRIVATE
  # ---------------
  defp values(list) do
    Enum.map(list, fn customer ->
      %{
        "name" => MCM.managed_customer(customer, :name),
        "customer_id" => MCM.managed_customer(customer, :customerId),
        "can_manage_clients" => MCM.managed_customer(customer, :canManageClients),
        "currency_code" => MCM.managed_customer(customer, :currencyCode),
        "date_time_zone" => MCM.managed_customer(customer, :dateTimeZone),
        "test_account" => MCM.managed_customer(customer, :testAccount),
        "exclude_hidden_accounts" =>
          MCM.managed_customer(customer, :excludeHiddenAccounts)
      }
    end)
  end
end
