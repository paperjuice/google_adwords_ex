defmodule AdWords.Types.BudgetMessage do
  @moduledoc false
  require Record
  import Record, only: [extract: 2, defrecord: 3]

  @path "include/budget.hrl"

  # --------------------
  # MUTATE
  # --------------------
  defrecord(
    :mutate,
    :mutate,
    extract(:mutate, from: @path)
  )

  defrecord(
    :budget_operation,
    :BudgetOperation,
    extract(:BudgetOperation, from: @path)
  )

  defrecord(
    :budget,
    :Budget,
    extract(:Budget, from: @path)
  )

  defrecord(
    :money,
    :Money,
    extract(:Money, from: @path)
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
    :budget_return_value,
    :BudgetReturnValue,
    extract(:BudgetReturnValue, from: @path)
  )

  # --------------------
  # GET
  # --------------------
  defrecord(
    :get,
    :get,
    extract(:get, from: @path)
  )

  defrecord(
    :selector,
    :Selector,
    extract(:Selector, from: @path)
  )

  defrecord(
    :predicate,
    :Predicate,
    extract(:Predicate, from: @path)
  )

  defrecord(
    :date_range,
    :DateRange,
    extract(:DateRange, from: @path)
  )

  defrecord(
    :order_by,
    :OrderBy,
    extract(:OrderBy, from: @path)
  )

  defrecord(
    :get_response,
    :getResponse,
    extract(:getResponse, from: @path)
  )

  defrecord(
    :budget_page,
    :BudgetPage,
    extract(:BudgetPage, from: @path)
  )
end
