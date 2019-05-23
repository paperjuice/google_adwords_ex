defmodule AdWords.Support.Factories.Services.GetCustomers do
  @moduledoc false
  defmacro __using__(_opts) do
    quote do
      def get_customers_google_response_factory do
        %{
          "record" =>
            {:getCustomersResponse,
             [
               {:Customer, '4074244805', 'SEK', 'Europe/Stockholm',
                'DragosTestAccount', true, true, false, :undefined, :undefined,
                false, {:ConversionTrackingSettings, '0', false},
                {:RemarketingSettings,
                 '<!-- Google Code for Remarketing Tag -->\n<!--------------------------------------------------\nRemarketing tags may not be associated with personally identifiable information or placed on pages related to sensitive categories. See more information and instructions on how to setup the tag on: http://google.com/ads/remarketingsetup\n--------------------------------------------------->\n<script type="text/javascript">\n/* <![CDATA[ */\nvar google_conversion_id = 792563399;\nvar google_custom_params = window.google_tag_params;\nvar google_remarketing_only = true;\n/* ]]> */\n</script>\n<script type="text/javascript" src="//www.googleadservices.com/pagead/conversion.js">\n</script>\n<noscript>\n<div style="display:inline;">\n<img height="1" width="1" style="border-style:none;" alt="" src="//googleads.g.doubleclick.net/pagead/viewthroughconversion/792563399/?guid=ON&amp;script=0"/>\n</div>\n</noscript>\n',
                 '<!-- Global site tag (gtag.js) - Google Ads: 792563399 -->\n<script async src="https://www.googletagmanager.com/gtag/js?id=AW-792563399"></script>\n<script>\n  window.dataLayer = window.dataLayer || [];\n  function gtag(){dataLayer.push(arguments);}\n  gtag(\'js\', new Date());\n\n  gtag(\'config\', \'AW-792563399\');\n</script>\n'}},
               {:Customer, '5834218976', 'SEK', 'Europe/Stockholm', 'Ads',
                false, true, false, :undefined, :undefined, false,
                {:ConversionTrackingSettings, '0', false},
                {:RemarketingSettings,
                 '<!-- Google Code for Remarketing Tag -->\n<!--------------------------------------------------\nRemarketing tags may not be associated with personally identifiable information or placed on pages related to sensitive categories. See more information and instructions on how to setup the tag on: http://google.com/ads/remarketingsetup\n--------------------------------------------------->\n<script type="text/javascript">\n/* <![CDATA[ */\nvar google_conversion_id = 790576233;\nvar google_custom_params = window.google_tag_params;\nvar google_remarketing_only = true;\n/* ]]> */\n</script>\n<script type="text/javascript" src="//www.googleadservices.com/pagead/conversion.js">\n</script>\n<noscript>\n<div style="display:inline;">\n<img height="1" width="1" style="border-style:none;" alt="" src="//googleads.g.doubleclick.net/pagead/viewthroughconversion/790576233/?guid=ON&amp;script=0"/>\n</div>\n</noscript>\n',
                 '<!-- Global site tag (gtag.js) - Google Ads: 790576233 -->\n<script async src="https://www.googletagmanager.com/gtag/js?id=AW-790576233"></script>\n<script>\n  window.dataLayer = window.dataLayer || [];\n  function gtag(){dataLayer.push(arguments);}\n  gtag(\'js\', new Date());\n\n  gtag(\'config\', \'AW-790576233\');\n</script>\n'}}
             ]}
        }
      end

      def get_customers_response_factory do
        %{
          "resp" => [
            %{
              "auto_tagging_enabled" => false,
              "can_manage_clients" => true,
              "currency_code" => "SEK",
              "customer_id" => "4074244805",
              "date_time_zone" => "Europe/Stockholm",
              "descriptive_name" => "DragosTestAccount",
              "final_url_suffix" => nil,
              "parallel_tracking_enabled" => false,
              "test_account" => true,
              "tracking_url_template" => nil
            },
            %{
              "auto_tagging_enabled" => false,
              "can_manage_clients" => false,
              "currency_code" => "SEK",
              "customer_id" => "5834218976",
              "date_time_zone" => "Europe/Stockholm",
              "descriptive_name" => "Ad",
              "final_url_suffix" => nil,
              "parallel_tracking_enabled" => false,
              "test_account" => true,
              "tracking_url_template" => nil
            }
          ]
        }
      end
    end
  end
end
