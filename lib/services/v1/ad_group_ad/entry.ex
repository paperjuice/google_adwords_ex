defmodule AdWords.Services.V1.AdGroupAd.Entry do
  @moduledoc false

  alias AdWords.Controller

  @base AdWords.Services.V1

  @doc """
  The function creates a multi asset responsive display ad.
  In order to create an ad of this type you need
  image ids which can be created by calling create_image/1.
  ## Supported parameters:
  ad_group_id             | REQUIRED | Group ID that the ad is going to be part of
  descriptions            | REQUIRED | descriptions (max 90 chars)
  business_name           | REQUIRED | the advertiser/brand name (max 25 chars)
  headlines               | REQUIRED | short format of the headline of the ad
  logo_images             | REQUIRED | minimum size is 128x128 and the aspect ratio must be 1:1
  long_headline           | REQUIRED | long format of the headline of the ad (max 90 chars)
  marketing_images        | REQUIRED | the minimum size is 600x314 and the aspect ratio must be 1.91:1
  square_marketing_images | REQUIRED | the minimum size is 300x300 and the aspect ratio must be 1:1
  final_urls              | REQUIRED | a list of possible final URLs after all cross domain redirects
  main_color              | OPTIONAL | if one of mainColor and accentColor is set, the other is required as well
  accent_color            | OPTIONAL | if one of mainColor and accentColor is set, the other is required as well
  allow_flexible_color    | OPTIONAL | field must be set to true if both mainColor and accentColor are not set
  call_to_action_text     | OPTIONAL | call to action text ¯\_(ツ)_/¯
  display_url             | OPTIONAL | URL displayed on the ad
  format_setting          | OPTIONAL | possible values: "NATIVE", "NON-NATIVE", "ALL_FORMATS"
  ## Example data:
  %{
    "ad_group_id" => "66583430772",
    "descriptions" => ["Awesome description"],
    "business_name" => "MyBus",
    "headlines" => ["My headline"],
    "logo_images" => ["216153042"],
    "marketing_images" => ["98544743"],
    "square_marketing_images" => ["99678319"],
    "long_headline" => "Long headline incoming",
    "main_color" => "#565656",
    "accent_color" => "#ffffff",
    "allow_flexible_color" => false,
    "call_to_action_text" => "Contact us",
    "final_urls" => ["https://hello.me/"],
    "format_setting" => "NON_NATIVE"
  }
  """
  @spec add_ad_multi_asset_ad(map()) :: list()
  def add_ad_multi_asset_ad(conn) do
    Controller.request(
      @base.AdGroupAd.Ad.MultiAssetAd.Add,
      :mutate,
      :ad_group_ad_service_client,
      conn
    )
  end
end
