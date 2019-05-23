defmodule AdWords.Types.AdGroupAdMessage do
  @moduledoc false
  require Record
  import Record, only: [extract: 2, defrecord: 3]

  @path "include/ad_group_ad.hrl"

  defrecord(
    :mutate,
    :mutate,
    extract(:mutate, from: @path)
  )

  defrecord(
    :ad_group_ad_operation,
    :AdGroupAdOperation,
    extract(:AdGroupAdOperation, from: @path)
  )

  defrecord(
    :ad_group_ad,
    :AdGroupAd,
    extract(:AdGroupAd, from: @path)
  )

  defrecord(
    :exemption_request,
    :ExemptionRequest,
    extract(:ExemptionRequest, from: @path)
  )

  defrecord(
    :policy_violation_key,
    :PolicyViolationKey,
    extract(:PolicyViolationKey, from: @path)
  )

  defrecord(
    :multi_asset_responsive_display_ad,
    :MultiAssetResponsiveDisplayAd,
    extract(:MultiAssetResponsiveDisplayAd, from: @path)
  )

  defrecord(
    :ad_group_ad_policy_summary,
    :AdGroupAdPolicySummary,
    extract(:AdGroupAdPolicySummary, from: @path)
  )

  defrecord(
    :label,
    :Label,
    extract(:Label, from: @path)
  )

  defrecord(
    :string_string_map_entry,
    :String_StringMapEntry,
    extract(:String_StringMapEntry, from: @path)
  )

  defrecord(
    :app_url,
    :AppUrl,
    extract(:AppUrl, from: @path)
  )

  defrecord(
    :custom_parameters,
    :CustomParameters,
    extract(:CustomParameters, from: @path)
  )

  defrecord(
    :custom_parameter,
    :CustomParameter,
    extract(:CustomParameter, from: @path)
  )

  defrecord(
    :url_data,
    :UrlData,
    extract(:UrlData, from: @path)
  )

  defrecord(
    :asset_link,
    :AssetLink,
    extract(:AssetLink, from: @path)
  )

  defrecord(
    :policy_topic_entry,
    :PolicyTopicEntry,
    extract(:PolicyTopicEntry, from: @path)
  )

  defrecord(
    :label_attribute,
    :LabelAttribute,
    extract(:LabelAttribute, from: @path)
  )

  defrecord(
    :display_attribute,
    :DisplayAttribute,
    extract(:DisplayAttribute, from: @path)
  )

  defrecord(
    :text_label,
    :TextLabel,
    extract(:TextLabel, from: @path)
  )

  defrecord(
    :asset_policy_summary_info,
    :AssetPolicySummaryInfo,
    extract(:AssetPolicySummaryInfo, from: @path)
  )

  defrecord(
    :text_asset,
    :TextAsset,
    extract(:TextAsset, from: @path)
  )

  defrecord(
    :image_asset,
    :ImageAsset,
    extract(:ImageAsset, from: @path)
  )

  defrecord(
    :image_dimension_info,
    :ImageDimensionInfo,
    extract(:ImageDimensionInfo, from: @path)
  )

  defrecord(
    :reseller_constraint,
    :ResellerConstraint,
    extract(:ResellerConstraint, from: @path)
  )

  defrecord(
    :url_list,
    :UrlList,
    extract(:UrlList, from: @path)
  )

  defrecord(
    :policy_topic_evidence,
    :PolicyTopicEvidence,
    extract(:PolicyTopicEvidence, from: @path)
  )

  defrecord(
    :policy_topic_constraint,
    :PolicyTopicConstraint,
    extract(:PolicyTopicConstraint, from: @path)
  )

  defrecord(
    :asset,
    :Asset,
    extract(:Asset, from: @path)
  )

  defrecord(
    :certificate_missing_in_country_constraint,
    :CertificateDomainMismatchInCountryConstraint,
    extract(:CertificateDomainMismatchInCountryConstraint, from: @path)
  )

  defrecord(
    :certificate_missing_constraint,
    :CertificateMissingConstraint,
    extract(:CertificateMissingConstraint, from: @path)
  )

  defrecord(
    :certificate_domain_mismatch_in_country_constrain,
    :CertificateMissingInCountryConstraint,
    extract(:CertificateMissingInCountryConstraint, from: @path)
  )

  defrecord(
    :country_constraint,
    :CountryConstraint,
    extract(:CountryConstraint, from: @path)
  )

  defrecord(
    :soap_header,
    :SoapHeader,
    extract(:SoapHeader, from: @path)
  )

  defrecord(
    :mutate_response,
    :mutateResponse,
    extract(:mutateResponse, from: @path)
  )

  defrecord(
    :ad_group_ad_return_value,
    :AdGroupAdReturnValue,
    extract(:AdGroupAdReturnValue, from: @path)
  )
end
