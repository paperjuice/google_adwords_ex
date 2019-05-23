ESpec.configure(fn config ->
  config.before(fn tags ->
    {:shared, hello: :world, tags: tags}
    {:ok, _} = Application.ensure_all_started(:ex_machina)
  end)

  config.finally(fn _shared ->
    :ok
  end)
end)
