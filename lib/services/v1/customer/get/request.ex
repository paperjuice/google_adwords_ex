defmodule AdWords.Services.V1.Customer.Get.Request do
  @moduledoc """
  TODO: Add documentation
  """

  require AdWords.Types.CustomerMessage

  alias AdWords.Types.CustomerMessage

  @spec request_message_record(any()) :: tuple()
  def request_message_record(_) do
    CustomerMessage.get_customers()
  end

  def header(params) do
    CustomerMessage.soap_header(
      clientCustomerId: Map.get(params, "client_customer_id", :undefined),
      developerToken: Map.get(params, "developer_token", :undefined),
      userAgent: Map.get(params, "user_agent", :undefined),
      validateOnly: Map.get(params, "validate_only", :undefined),
      partialFailure: Map.get(params, "partial_failure", :undefined)
    )
  end
end
