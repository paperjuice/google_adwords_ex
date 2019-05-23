defmodule AdWords.Asset.GetCustomersSpec do
  @moduledoc false

  use ESpec

  import AdWords.Support.Factories

  let(:get_customers_google_response) do
    build(:get_customers_google_response)["record"]
  end

  let(:get_customers_response) do
    build(:get_customers_response)["resp"]
  end

  context "Happty path for get customers" do
    before do
      allow(
        :customer_service_client
        |> to(
          accept(
            :getCustomers,
            fn _body, _header, _opts ->
              {:ok, 200, [], [], get_customers_google_response(), [], "xml"}
            end
          )
        )
      )
    end

    it "returns successful response when valid data is used" do
      actual = AdWords.get_customers()

      expect(actual) |> to(eq(get_customers_response()))
    end
  end
end
