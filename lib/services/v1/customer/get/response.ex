defmodule AdWords.Services.V1.Customer.Get.Response do
  @moduledoc """
  TODO: Add documentation + response msg data structure
  """

  require AdWords.Types.CustomerMessage

  alias AdWords.Types.CustomerMessage
  alias AdWords.Services.Shared

  def handle_successful_response(record, conn) do
    data =
      record
      |> CustomerMessage.get_customers_response(:rval)
      |> build_customer_list()

    Shared.add_resp_to_conn(conn, data, 201, "get_customer")
  end

  # ---------------
  # PRIVATE
  # ---------------
  defp build_customer_list(customers) do
    for customer <- customers do
      %{
        # TODO: Add function to handle value better
        "customer_id" =>
          CustomerMessage.customer(customer, :customerId) |> parse(),
        "currency_code" =>
          CustomerMessage.customer(customer, :currencyCode) |> parse(),
        "date_time_zone" =>
          CustomerMessage.customer(customer, :dateTimeZone) |> parse(),
        "descriptive_name" =>
          CustomerMessage.customer(customer, :descriptiveName) |> parse(),
        "can_manage_clients" =>
          CustomerMessage.customer(customer, :canManageClients) |> parse(),
        "test_account" =>
          CustomerMessage.customer(customer, :testAccount) |> parse(),
        "auto_tagging_enabled" =>
          CustomerMessage.customer(customer, :autoTaggingEnabled) |> parse(),
        "tracking_url_template" =>
          CustomerMessage.customer(customer, :trackingUrlTemplate) |> parse(),
        "final_url_suffix" =>
          CustomerMessage.customer(customer, :finalUrlSuffix) |> parse(),
        "parallel_tracking_enabled" =>
          CustomerMessage.customer(customer, :parallelTrackingEnabled) |> parse()
      }
    end
  end

  defp parse(value) do
    cond do
      is_list(value) -> List.to_string(value)
      value == :undefined -> nil
      true -> value
    end
  end
end
