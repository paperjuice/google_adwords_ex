defmodule AdWords.Services.V1.Asset.Entry do
  @moduledoc false

  alias AdWords.Controller

  @base AdWords.Services.V1

  @doc """
  Creates an image on the Google dev account
  and returns an ID which is required by
  `create_multi_asset_ad/1`.
  Names can be used once.
  ## Supported parameters:
  * image_url  | REQUIRED | the url where the image is located
  * asset_name | OPTIONAL | the name of the newly created asset
  ## Example data:
  %{
    "asset_name" => "Marketing image 2",
    "image_url" => "https://i.imgur.com/XvxoFov.png"
  }
  """
  @spec add_image(map()) :: list()
  def add_image(conn) do
    Controller.request(
      @base.Asset.Image.Add,
      :mutate,
      :asset_service_client,
      conn
    )
  end
end
