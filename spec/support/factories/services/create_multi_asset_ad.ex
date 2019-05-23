defmodule AdWords.Support.Factories.Services.CreateMultiAssetAd do
  @moduledoc false
  defmacro __using__(_opts) do
    quote do
      def create_multi_asset_ad_params_factory do
        %{
          "ad_group_id" => "1234",
          "descriptions" => ["Descriptions"],
          "business_name" => "Business Test",
          "headlines" => ["Headline"],
          "logo_images" => ["1234"],
          "marketing_images" => ["1234"],
          "square_marketing_images" => ["1234"],
          "long_headline" => "Long headline",
          "main_color" => "#ffffff",
          "accent_color" => "#ffffff",
          "allow_flexible_color" => false,
          "call_to_action_text" => "Test",
          "final_urls" => ["https://final.urls/"],
          "format_setting" => "NON_NATIVE"
        }
      end

      def create_multi_asset_ad_response_factory do
        %{
          "record" =>
            {:mutateResponse,
             {:AdGroupAdReturnValue, 'AdGroupAdReturnValue',
              [
                {:AdGroupAd, '61865800687',
                 {:MultiAssetResponsiveDisplayAd, '290574662125', :undefined,
                  :undefined, ['https://hello.me/'], :undefined, :undefined,
                  :undefined, :undefined, :undefined, :undefined, :undefined,
                  'MULTI_ASSET_RESPONSIVE_DISPLAY_AD', :undefined, :undefined,
                  'MultiAssetResponsiveDisplayAd',
                  [
                    {:AssetLink,
                     {:ImageAsset, '92417072', 'MyBus banner 2', 'IMAGE',
                      :undefined, 'ImageAsset', :undefined, '402282', 'IMAGE_PNG',
                      {:ImageDimensionInfo, 600, 1146, :undefined}}, :undefined,
                     :undefined, :undefined}
                  ],
                  [
                    {:AssetLink,
                     {:ImageAsset, '93087091', 'SquareMarketingImage', 'IMAGE',
                      :undefined, 'ImageAsset', :undefined, '20549', 'IMAGE_JPEG',
                      {:ImageDimensionInfo, 510, 510, :undefined}}, :undefined,
                     :undefined, :undefined}
                  ],
                  [
                    {:AssetLink,
                     {:ImageAsset, '93697200', 'MyBus Logo', 'IMAGE', :undefined,
                      'ImageAsset', :undefined, '14140', 'IMAGE_JPEG',
                      {:ImageDimensionInfo, 258, 258, :undefined}}, :undefined,
                     :undefined, :undefined}
                  ], :undefined,
                  [
                    {:AssetLink,
                     {:TextAsset, '93155914', :undefined, 'TEXT', :undefined,
                      'TextAsset', 'Global Marketing Platform'}, :undefined,
                     :undefined, :undefined}
                  ],
                  {:AssetLink,
                   {:TextAsset, '93155917', :undefined, 'TEXT', :undefined,
                    'TextAsset',
                    'Global Content and Influencer Marketing Platform'},
                   :undefined, :undefined, :undefined},
                  [
                    {:AssetLink,
                     {:TextAsset, '93155920', :undefined, 'TEXT', :undefined,
                      'TextAsset',
                      'We deliver high-performing campaigns and authentic content at scale.'},
                     :undefined, :undefined, :undefined}
                  ], 'VAMP', '#565656', '#ffffff', false, 'Contact us',
                  :undefined, :undefined, 'NON_NATIVE'}, 'ENABLED',
                 {:AdGroupAdPolicySummary, :undefined, 'REVIEW_IN_PROGRESS',
                  :undefined, 'UNDER_REVIEW'}, :undefined, :undefined, :undefined,
                 :undefined}
              ], :undefined}}
        }
      end
    end
  end
end
