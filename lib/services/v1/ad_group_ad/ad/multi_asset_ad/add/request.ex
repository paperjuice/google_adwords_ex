defmodule AdWords.Services.V1.AdGroupAd.Ad.MultiAssetAd.Add.Request do
  @moduledoc """
  TODO: Add documentation
  """

  require AdWords.Types.AdGroupAdMessage

  alias AdWords.Types.AdGroupAdMessage, as: AGA

  # TODO: Add comprehensive spec attribute
  @spec request_message_record(map()) :: tuple()
  def request_message_record(parameters) do
    AGA.mutate(
      operations: parameters |> Map.get("operations", :undefined) |> operations()
    )
  end

  def operations(:undefined), do: :undefined

  def operations(operations) do
    Enum.map(operations, fn map ->
      AGA.ad_group_ad_operation(
        operator: map |> Map.get("operator", :undefined),
        "Operation.Type": map |> Map.get("operation_type", :undefined),
        operand: map |> Map.get("operand", :undefined) |> ad_group_ad(),
        exemptionRequests:
          map
          |> Map.get("exemption_requests", :undefined)
          |> exemption_request(),
        ignorablePolicyTopicIds:
          map |> Map.get("ignorable_policy_topic_ids", :undefined)
      )
    end)
  end

  def ad_group_ad(:undefined), do: :undefined

  def ad_group_ad(ad_group_ad) do
    AGA.ad_group_ad(
      adGroupId: Map.get(ad_group_ad, "ad_group_id", :undefined),
      ad: ad_group_ad |> Map.get("ad", :undefined) |> ad(),
      status: Map.get(ad_group_ad, "status", :undefined),
      policySummary:
        ad_group_ad |> Map.get("policy_summary", :undefined) |> policy_summary(),
      labels: ad_group_ad |> Map.get("labels", :undefined) |> labels(),
      baseCampaignId: Map.get(ad_group_ad, "base_campaign_id", :undefined),
      baseAdGroupId: Map.get(ad_group_ad, "base_ad_group_id", :undefined),
      forwardCompatibilityMap:
        ad_group_ad
        |> Map.get("forward_compatibility_map", :undefined)
        |> forward_compatibility_map()
    )
  end

  def ad(:undefined), do: :undefined
  def ad(%{"multi_asset_ad" => data}), do: multi_asset_ad(data)

  def multi_asset_ad(multi_asset_ad) do
    AGA.multi_asset_responsive_display_ad(
      id: Map.get(multi_asset_ad, "id", :undefined),
      url: Map.get(multi_asset_ad, "url", :undefined),
      displayUrl: Map.get(multi_asset_ad, "display_url", :undefined),
      finalUrls: Map.get(multi_asset_ad, "final_urls", :undefined),
      finalMobileUrls: Map.get(multi_asset_ad, "final_mobile_urls", :undefined),
      finalAppUrls:
        multi_asset_ad
        |> Map.get("final_app_urls", :undefined)
        |> final_app_urls(),
      trackingUrlTemplate:
        Map.get(multi_asset_ad, "tracking_url_template", :undefined),
      finalUrlSuffix: Map.get(multi_asset_ad, "final_url_suffix", :undefined),
      urlCustomParameters:
        multi_asset_ad
        |> Map.get("url_custom_parameters", :undefined)
        |> custom_parameters(),
      urlData: multi_asset_ad |> Map.get("url_data", :undefined) |> url_data(),
      automated: Map.get(multi_asset_ad, "automated", :undefined),
      type: Map.get(multi_asset_ad, "type", :undefined),
      devicePreference: Map.get(multi_asset_ad, "device_preference", :undefined),
      systemManagedEntitySource:
        Map.get(multi_asset_ad, "system_managed_entity_source", :undefined),
      "Ad.Type": Map.get(multi_asset_ad, "ad_type", :undefined),
      marketingImages:
        multi_asset_ad |> Map.get("marketing_images", :undefined) |> asset_link(),
      squareMarketingImages:
        multi_asset_ad
        |> Map.get("square_marketing_images", :undefined)
        |> asset_link(),
      logoImages:
        multi_asset_ad |> Map.get("logo_images", :undefined) |> asset_link(),
      landscapeLogoImages:
        multi_asset_ad
        |> Map.get("landscape_logo_images", :undefined)
        |> asset_link(),
      headlines:
        multi_asset_ad |> Map.get("headlines", :undefined) |> asset_link(),
      longHeadline:
        multi_asset_ad |> Map.get("long_headline", :undefined) |> asset_link(),
      descriptions:
        multi_asset_ad |> Map.get("descriptions", :undefined) |> asset_link(),
      businessName: Map.get(multi_asset_ad, "business_name", :undefined),
      mainColor: Map.get(multi_asset_ad, "main_color", :undefined),
      accentColor: Map.get(multi_asset_ad, "accent_color", :undefined),
      allowFlexibleColor:
        Map.get(multi_asset_ad, "allow_flexible_color", :undefined),
      callToActionText:
        Map.get(multi_asset_ad, "call_to_action_text", :undefined),
      dynamicSettingsPricePrefix:
        Map.get(multi_asset_ad, "dynamic_settings_price_prefix", :undefined),
      dynamicSettingsPromoText:
        Map.get(multi_asset_ad, "dynamic_settings_promo_text", :undefined),
      formatSetting: Map.get(multi_asset_ad, "format_setting", :undefined)
    )
  end

  def exemption_request(:undefined), do: :undefined

  def exemption_request(exemption_request) do
    Enum.map(exemption_request, fn map ->
      AGA.exemption_request(
        key: map |> Map.get("key", :undefined) |> policy_violation_key()
      )
    end)
  end

  def policy_summary(:undefined), do: :undefined

  def policy_summary(policy_summary) do
    Enum.map(policy_summary, fn map ->
      AGA.ad_group_ad_policy_summary(
        policyTopicEntries: ListPolicyTopicEntry,
        reviewState: Map.get(map, "review_state", :undefined),
        denormalizedStatus: Map.get(map, "denormalized_status", :undefined),
        combinedApprovalStatus:
          Map.get(map, "combined_approval_status", :undefined)
      )
    end)
  end

  def labels(:undefined), do: :undefined
  def labels([]), do: :undefined

  def labels(labels) do
    Enum.map(labels, fn {key, value} ->
      case key do
        "label" -> label(value)
        "text_label" -> text_label(value)
      end
    end)
  end

  def label(data) do
    AGA.label(
      id: Map.get(data, "id", :undefined),
      name: Map.get(data, "name", :undefined),
      status: Map.get(data, "status", :undefined),
      "Label.Type": Map.get(data, "label_type", :undefined),
      attribute: data |> Map.get("attribute", :undefined) |> attribute()
    )
  end

  def text_label(data) do
    AGA.label(
      id: Map.get(data, "id", :undefined),
      name: Map.get(data, "name", :undefined),
      status: Map.get(data, "status", :undefined),
      "Label.Type": Map.get(data, "label_type", :undefined),
      attribute: data |> Map.get("attribute", :undefined) |> attribute()
    )
  end

  def forward_compatibility_map(:undefined), do: :undefined

  def forward_compatibility_map(forward_compatibility_map) do
    Enum.map(forward_compatibility_map, fn map ->
      AGA.string_string_map_entry(
        key: Map.get(map, "key", :undefined),
        value: Map.get(map, "value", :undefined)
      )
    end)
  end

  def final_app_urls(:undefined), do: :undefined

  def final_app_urls(final_app_urls) do
    Enum.map(final_app_urls, fn map ->
      AGA.app_url(
        url: Map.get(map, "url", :undefined),
        osType: Map.get(map, "os_type", :undefined)
      )
    end)
  end

  def custom_parameters(:undefined), do: :undefined

  def custom_parameters(custom_parameters) do
    AGA.custom_parameters(
      parameters:
        custom_parameters
        |> Map.get("parameters", :undefined)
        |> custom_parameter(),
      doReplace: Map.get(custom_parameters, "do_replace", :undefined)
    )
  end

  def custom_parameter(:undefined), do: :undefined

  def custom_parameter(custom_parameter) do
    AGA.custom_parameter(
      key: Map.get(custom_parameter, "key", :undefined),
      value: Map.get(custom_parameter, "value", :undefined),
      isRemove: Map.get(custom_parameter, "is_remove", :undefined)
    )
  end

  def url_data(:undefined), do: :undefined

  def url_data(url_data) do
    AGA.url_data(
      urlId: Map.get(url_data, "url_id", :undefined),
      finalUrls: url_data |> Map.get("final_urls", :undefined) |> url_list(),
      finalMobileUrls:
        url_data |> Map.get("final_mobile_urls", :undefined) |> url_list(),
      trackingUrlTemplate: Map.get(url_data, "tracking_url_template", :undefined)
    )
  end

  def asset_link(:undefined), do: :undefined

  def asset_link(asset_link) when is_list(asset_link) do
    Enum.map(asset_link, fn map ->
      AGA.asset_link(
        asset: map |> Map.get("asset", :undefined) |> asset(),
        pinnedField: Map.get(map, "pinned_filed", :undefined),
        assetPolicySummaryInfo:
          map
          |> Map.get("asset_policy_summary_info", :undefined)
          |> asset_policy_summary_info(),
        assetPerformanceLabel: Map.get(map, "asset_performance_label", :undefined)
      )
    end)
  end

  def asset_link(asset_link) do
    AGA.asset_link(
      asset: asset_link |> Map.get("asset", :undefined) |> asset(),
      pinnedField: Map.get(asset_link, "pinned_filed", :undefined),
      assetPolicySummaryInfo:
        asset_link
        |> Map.get("asset_policy_summary_info", :undefined)
        |> asset_policy_summary_info(),
      assetPerformanceLabel:
        Map.get(asset_link, "asset_performance_label", :undefined)
    )
  end

  def policy_violation_key(:undefined), do: :undefined

  def policy_violation_key(policy_violation_key) do
    AGA.policy_violation_key(
      policyName: Map.get(policy_violation_key, "policy_name", :undefined),
      violatingText: Map.get(policy_violation_key, "violating_text", :undefined)
    )
  end

  def attribute(:undefined), do: :undefined

  def attribute(%{"label_attribute" => data}) do
    AGA.label_attribute(
      "LabelAttribute.Type": Map.get(data, "label_attribute_type", :undefined)
    )
  end

  def attribute(%{"display_attribute" => data}) do
    AGA.display_attribute(
      "LabelAttribute.Type": Map.get(data, "label_attribute_type", :undefined),
      backgroundColor: Map.get(data, "background_color", :undefined),
      description: Map.get(data, "description", :undefined)
    )
  end

  def url_list(:undefined), do: :undefined

  def url_list(url_list) do
    AGA.url_list(urls: Map.get(url_list, "urls", :undefined))
  end

  def asset(:undefined), do: :undefined

  def asset(%{"asset" => data}) do
    AGA.asset(
      assetId: Map.get(data, "asset_id", :undefined),
      assetName: Map.get(data, "asset_name", :undefined),
      assetSubtype: Map.get(data, "asset_subtype", :undefined),
      assetStatus: Map.get(data, "asset_status", :undefined),
      "Asset.Type": Map.get(data, "asset_type", :undefined)
    )
  end

  def asset(%{"text_asset" => data}) do
    AGA.text_asset(
      assetId: Map.get(data, "asset_id", :undefined),
      assetName: Map.get(data, "asset_name", :undefined),
      assetSubtype: Map.get(data, "asset_subtype", :undefined),
      assetStatus: Map.get(data, "asset_status", :undefined),
      "Asset.Type": Map.get(data, "asset_type", :undefined),
      assetText: Map.get(data, "asset_text", :undefined)
    )
  end

  def asset(%{"image_asset" => data}) do
    AGA.image_asset(
      assetId: Map.get(data, "asset_id", :undefined),
      assetName: Map.get(data, "asset_name", :undefined),
      assetSubtype: Map.get(data, "asset_subtype", :undefined),
      assetStatus: Map.get(data, "asset_status", :undefined),
      "Asset.Type": Map.get(data, "asset_type", :undefined),
      imageData: Map.get(data, "image_data", :undefined),
      imageFileSize: Map.get(data, "asset_file_size", :undefined),
      imageMimeType: Map.get(data, "image_mime_type", :undefined),
      fullSizeInfo:
        data |> Map.get("full_size_info", :undefined) |> image_dimension_info()
    )
  end

  def image_dimension_info(:undefined), do: :undefined

  def image_dimension_info(image_dimension_info) do
    AGA.image_dimension_info(
      imageHeight: Map.get(image_dimension_info, "image_height", :undefined),
      imageWidth: Map.get(image_dimension_info, "image_width", :undefined),
      imageUrl: Map.get(image_dimension_info, "image_url", :undefined)
    )
  end

  def asset_policy_summary_info(:undefined), do: :undefined

  def asset_policy_summary_info(asset_policy_summary_info) do
    AGA.asset_policy_summary_info(
      policyTopicEntries:
        asset_policy_summary_info
        |> Map.get("policy_topic_entries", :undefined)
        |> policy_topic_entry(),
      reviewState: Map.get(asset_policy_summary_info, "review_state", :undefined),
      denormalizedStatus:
        Map.get(asset_policy_summary_info, "denormalized_status", :undefined),
      combinedApprovalStatus:
        Map.get(asset_policy_summary_info, "combined_approval_status", :undefined),
      "PolicySummaryInfo.Type":
        Map.get(asset_policy_summary_info, "policy_summary_info_type", :undefined)
    )
  end

  def policy_topic_entry(:undefined), do: :undefined

  def policy_topic_entry(policy_topic_entries) do
    Enum.map(policy_topic_entries, fn map ->
      AGA.policy_topic_entry(
        policyTopicEntryType: Map.get(map, "policy_topic_entry_type", :undefined),
        policyTopicEvidences:
          map
          |> Map.get("policy_topic_evidence", :undefined)
          |> policy_topic_evidence(),
        policyTopicConstraints:
          map
          |> Map.get("policy_topic_constraints", :undefined)
          |> policy_topic_constraints(),
        policyTopicId: Map.get(map, "policy_topic_id", :undefined),
        policyTopicName: Map.get(map, "policy_topic_name", :undefined),
        policyTopicHelpCenterUrl:
          Map.get(
            map,
            "policy_topic_help_center_url",
            :undefined
          )
      )
    end)
  end

  def policy_topic_evidence(:undefined), do: :undefined

  def policy_topic_evidence(policy_topic_evidence) do
    Enum.map(policy_topic_evidence, fn map ->
      AGA.policy_topic_evidence(
        policyTopicEvidenceType:
          Map.get(map, "policy_topic_evidence_type", :undefined),
        evidenceTextList: Map.get(map, "evidence_text_list", :undefined),
        policyTopicEvidenceDestinationMismatchUrlTypes:
          Map.get(
            map,
            "policy_topic_evidence_destination_mismatch_url_types",
            :undefined
          )
      )
    end)
  end

  def policy_topic_constraints(:undefined), do: :undefined

  def policy_topic_constraints(policy_topic_constraints) do
    Enum.map(policy_topic_constraints, fn {key, value} ->
      case key do
        "policy_topic_constraint" ->
          policy_topic_constraint(value)

        "certificate_missing_in_country_constraint" ->
          certificate_missing_in_country_constraint(value)

        "certificate_domain_mismatch_in_country_constraint" ->
          certificate_domain_mismatch_in_country_constraint(value)

        "reseller_constraint" ->
          reseller_constraint(value)

        "country_constraint" ->
          country_constraint(value)

        "certificate_missing_constraint" ->
          certificate_missing_constraint(value)
      end
    end)
  end

  def policy_topic_constraint(map) do
    AGA.policy_topic_constraint(
      constraintType: Map.get(map, "contraint_type", :undefined),
      "PolicyTopicConstraint.Type":
        Map.get(map, "policy_topic_constraint_type", :undefined)
    )
  end

  def certificate_missing_in_country_constraint(map) do
    AGA.certificate_missing_in_country_constraint(
      constraintType: Map.get(map, "contraint_type", :undefined),
      "PolicyTopicConstraint.Type":
        Map.get(map, "policy_topic_constraint_type", :undefined),
      constrainedCountries: Map.get(map, "constrained_countries", :undefined),
      totalTargetedCountries: Map.get(map, "total_targeted_countries", :undefined)
    )
  end

  def certificate_domain_mismatch_in_country_constraint(map) do
    AGA.certificate_domain_mismatch_in_country_constrain(
      constraintType: Map.get(map, "contraint_type", :undefined),
      "PolicyTopicConstraint.Type":
        Map.get(map, "policy_topic_constraint_type", :undefined),
      constrainedCountries: Map.get(map, "constrained_countries", :undefined),
      totalTargetedCountries: Map.get(map, "total_targeted_countries", :undefined)
    )
  end

  def reseller_constraint(map) do
    AGA.reseller_constraint(
      constraintType: Map.get(map, "contraint_type", :undefined),
      "PolicyTopicConstraint.Type":
        Map.get(map, "policy_topic_constraint_type", :undefined)
    )
  end

  def country_constraint(map) do
    AGA.country_constraint(
      constraintType: Map.get(map, "contraint_type", :undefined),
      "PolicyTopicConstraint.Type":
        Map.get(map, "policy_topic_constraint_type", :undefined),
      constrainedCountries: Map.get(map, "constrained_countries", :undefined),
      totalTargetedCountries: Map.get(map, "total_targeted_countries", :undefined)
    )
  end

  def certificate_missing_constraint(map) do
    AGA.certificate_missing_constraint(
      constraintType: Map.get(map, "contraint_type", :undefined),
      "PolicyTopicConstraint.Type":
        Map.get(map, "policy_topic_constraint_type", :undefined)
    )
  end

  # TODO: this one exists in CreateImage.Request. Maybe move it to a common place???
  def header(params) do
    AGA.soap_header(
      clientCustomerId: Map.get(params, "client_customer_id", :undefined),
      developerToken: Map.get(params, "developer_token", :undefined),
      userAgent: Map.get(params, "user_agent", :undefined),
      validateOnly: Map.get(params, "validate_only", :undefined),
      partialFailure: Map.get(params, "partial_failure", :undefined)
    )
  end
end
