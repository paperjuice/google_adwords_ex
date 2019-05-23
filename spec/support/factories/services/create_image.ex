defmodule AdWords.Support.Factories.Services.CreateImage do
  @moduledoc false
  defmacro __using__(_opts) do
    quote do
      def create_image_params_factory do
        %{
          "asset_name" => "Asset name",
          "image_url" => "https://picture.jpg"
        }
      end

      def invalid_create_image_params_factory do
        %{
          "image_url" => ""
        }
      end

      # TODO: make it look like create_multi_asset_response
      def create_image_response_factory do
        %{
          "record" =>
            {:ok, 200, [], [],
             {:mutateResponse,
              {:AssetReturnValue, 'AssetReturnValue',
               [
                 {:ImageAsset, '11111111', 'Marketing Image', 'IMAGE', 'ENABLED',
                  'ImageAsset', :undefined, '721665', 'IMAGE_PNG',
                  {:ImageDimensionInfo, 989, 1890,
                   'https://tpc.googlesyndication.com/simgad/2200374443426933378'}}
               ]}}, [], ""}
        }
      end

      def invalid_create_image_response_factory do
        %{"record" => {:error, 500, "", "", {:error}, "", ""}}
      end
    end
  end
end
