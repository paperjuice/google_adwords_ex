defmodule AdWords.Asset.CreateMultiAssetAdSpec do
  @moduledoc false

  use ESpec

  import AdWords.Support.Factories

  let(:create_multi_asset_ad_response) do
    build(:create_multi_asset_ad_response)["record"]
  end

  context "Happy path for create multi-asset Ad" do
    before do
      allow(
        :ad_group_ad_service_client
        |> to(
          accept(
            :mutate,
            fn _body, _header, _opts ->
              {:ok, 200, [], [], create_multi_asset_ad_response(), [], "xml"}
            end
          )
        )
      )
    end

    it "returns successful response when valid data is used" do
      params = build(:create_multi_asset_ad_params)
      actual = AdWords.create_multi_asset_ad(params)

      expect(actual) |> to(eq([290_574_662_125]))
    end
  end
end
