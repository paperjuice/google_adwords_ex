defmodule AdWords.Asset.CreateImagesSpec do
  @moduledoc false

  use ESpec

  import AdWords.Support.Factories

  let(:create_image_response) do
    build(:create_image_response)["record"]
  end

  let(:invalid_create_image_response) do
    build(:invalid_create_image_response)["record"]
  end

  context "Happy path for create image assets" do
    before do
      allow(HTTPoison |> to(accept(:get!, fn _url -> %{body: "string"} end)))

      allow(
        :asset_service_client
        |> to(
          accept(
            :mutate,
            fn _body, _header, _opts ->
              create_image_response()
            end
          )
        )
      )
    end

    it "returns successful response when valid data is used" do
      params = build(:create_image_params)
      actual = AdWords.create_image(params)

      expect(actual) |> to(eq([11_111_111]))
    end
  end

  context "Unhappy path for create image assets" do
    before do
      allow(HTTPoison |> to(accept(:get!, fn _url -> %{body: "string"} end)))

      allow(
        :asset_service_client
        |> to(
          accept(
            :mutate,
            fn _body, _header, _opts ->
              invalid_create_image_response()
            end
          )
        )
      )
    end

    it "returns unsuccessful response when invalid data is used" do
      params = build(:invalid_create_image_params)
      actual = AdWords.create_image(params)

      expect(actual) |> to(eq({:error, {:error}}))
    end
  end
end
